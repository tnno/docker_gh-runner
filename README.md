# Github Runner in Docker for Kubernetes

## Examples
### Kubernetes
```
cat <<'EOF' | kubectl apply -f -
apiVersion: v1 
kind: Pod 
metadata: 
    name: gh-runner 
spec: 
    containers: 
      - name: gh-runner
        image: ghcr.io/tnno/docker_gh-runner:main
        imagePullPolicy: Always
        env:
          - name: TOKEN
            value: INSERT_YOUR_TOKEN_HERE
          - name: GH_URL
            value: https://github.com/YOUR_GITHUB_USERNAME/YOUR_GITHUB_REPOSITORY
          - name: DOCKER_HOST 
            value: tcp://localhost:2375 
      - name: dind-daemon 
        image: docker:20-dind-rootless
        resources: 
            requests: 
                cpu: 20m 
                memory: 512Mi 
        securityContext: 
            privileged: true 
        volumeMounts: 
          - name: docker-graph-storage 
            mountPath: /var/lib/docker 
    volumes: 
      - name: docker-graph-storage 
        emptyDir: {}
EOF
```