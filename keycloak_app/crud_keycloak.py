from fastapi import FastAPI, Depends, HTTPException
from keycloak import KeycloakOpenID

app = FastAPI()
keycloak_openid = KeycloakOpenID(server_url="https://keycloak.example.com/auth/",
                                 client_id="your-client-id",
                                 realm_name="your-realm",
                                 client_secret_key="your-client-secret")

# Define roles required for various actions
roles_required = {
    "create_record": ["admin"],
    "view_detail": ["user", "admin"],
    "delete_record": ["admin"]
}


def check_permissions(token: str = Depends(keycloak_openid), action: str = None):
    user_roles = token.get('resource_access', {}).get('your-client-id', {}).get('roles', [])
    required_roles = roles_required.get(action, [])

    # Check if any of the required roles are present in user's roles
    if not any(role in user_roles for role in required_roles):
        raise HTTPException(status_code=403, detail="User does not have permission to perform this action")


@app.post("/create-record")
async def create_record(token: str = Depends(keycloak_openid)):
    check_permissions(token, action="create_record")
    # Logic to create record


@app.get("/view-detail")
async def view_detail(token: str = Depends(keycloak_openid)):
    check_permissions(token, action="view_detail")
    # Logic to view record detail


@app.delete("/delete-record")
async def delete_record(token: str = Depends(keycloak_openid)):
    check_permissions(token, action="delete_record")
    # Logic to delete record
