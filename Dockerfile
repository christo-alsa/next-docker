# Étape 1 : Construire l'application
FROM node:20-alpine AS builder

WORKDIR /app

# Copier package.json et package-lock.json pour installer uniquement les dépendances nécessaires
COPY package*.json ./

RUN npm install

# Copier le reste du projet
COPY . .

# Construire l'application Next.js
RUN npm run build

# Étape 2 : Exécuter l'application
FROM node:20-alpine AS runner

WORKDIR /app

COPY --from=builder /app ./

EXPOSE 3000

CMD ["npm", "run", "start"]
