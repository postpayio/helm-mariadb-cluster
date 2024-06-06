{{- range $name, $value := .Values.grant }}
---
apiVersion: k8s.mariadb.com/v1alpha1
kind: Grant
{{ include "resourceValues" (list $name $value) }}
{{- end }}