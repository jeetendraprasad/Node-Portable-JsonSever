
Invoke-WebRequest -Uri 'http://localhost:3001/register' `
	-Method POST `
	-Body (@{ email='monster@gmail.com'; password='12345678' } | ConvertTo-Json) `
	-ContentType 'application/json'
	
Invoke-WebRequest -Uri 'http://localhost:3001/posts'