From node:alpine as builder
Workdir '/app'
Copy ./package.json ./
Run npm install
Copy . .
Run npm run build 

From nginx
Expose 3000
Copy ./nginx.conf /etc/nginx/conf.d/default.conf
Workdir '/usr/share/nginx/html'
Copy --from=builder /app/build /usr/share/nginx/html
