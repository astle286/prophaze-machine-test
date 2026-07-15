{{/*
Chart Name
*/}}
{{- define "order-service.name" -}}
{{- .Chart.Name -}}
{{- end }}

{{/*
Full Resource Name
*/}}
{{- define "order-service.fullname" -}}
{{- .Release.Name -}}
{{- end }}

{{/*
Common Kubernetes Labels
*/}}
{{- define "order-service.labels" -}}
app.kubernetes.io/name: {{ include "order-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}

{{/*
Selector Labels
*/}}
{{- define "order-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "order-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}