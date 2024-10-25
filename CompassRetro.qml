import QtQuick 2.0

Canvas {
    id: root
    width: 1024
    height: 1024

    property double outerRadius: 1024 / 2
    property double cx: outerRadius
    property double cy: outerRadius
    property double heading: 0

    onHeadingChanged: requestPaint()

    onPaint: {
        var ctx = getContext("2d")
        ctx.reset()

        drawNumbers(ctx)
        drawTickmarks(ctx)
        drawSecondaryLabels(ctx)
        drawPrimaryLabels(ctx)
        drawNeedle(ctx)
    }

    function drawNeedle(ctx) {
        ctx.save()

        ctx.translate(cx, cy)
        ctx.rotate((heading) / 180.0 * Math.PI)
        ctx.translate(-cx, -cy)

        // Red
        const redGradient = ctx.createLinearGradient(cx - 30, 0, cx + 30, 0)
        redGradient.addColorStop(0, "#ff0000")
        redGradient.addColorStop(1, "#7f0000")

        ctx.beginPath()
        ctx.moveTo(cx, cy)
        ctx.arc(cx, cy, 45, Math.PI, 0)
        ctx.closePath()
        ctx.fillStyle = redGradient
        ctx.fill()

        ctx.beginPath()
        ctx.moveTo(cx + 30, cy)
        ctx.lineTo(cx, 100)
        ctx.lineTo(cx - 30, cy)
        ctx.closePath()
        ctx.fillStyle = redGradient
        ctx.fill()

        // Gray
        const blueGradient = ctx.createLinearGradient(cx - 30, 0, cx + 30, 0)
        blueGradient.addColorStop(0, "#666666")
        blueGradient.addColorStop(1, "#111111")

        ctx.beginPath()
        ctx.moveTo(cx, cy)
        ctx.arc(cx, cy, 45, Math.PI, 0, true)
        ctx.closePath()
        ctx.fillStyle = blueGradient
        ctx.fill()

        ctx.beginPath()
        ctx.moveTo(cx + 30, cy)
        ctx.lineTo(cx, 2 * cy - 100)
        ctx.lineTo(cx - 30, cy)
        ctx.closePath()
        ctx.fillStyle = blueGradient
        ctx.fill()

        // Foreground
        ctx.beginPath()
        ctx.moveTo(cx, cy)
        ctx.arc(cx, cy, 27, 0, 2 * Math.PI)
        ctx.closePath()
        ctx.fillStyle = "#ffffff"
        ctx.fill()

        ctx.restore()
    }

    function drawSecondaryLabels(ctx) {
        ctx.save()

        const labels = ['NE', 'SE', 'SW', 'NW']
        const angles = [0, 90, 180, 270]

        for (var i = 0; i < 4; i++) {
            ctx.save()

            ctx.translate(cx, cy)
            ctx.rotate((angles[i] + 45) / 180.0 * Math.PI)
            ctx.translate(-cx, -cy)

            ctx.beginPath()
            ctx.moveTo(cx, cy - 180)
            ctx.lineTo(cx - 25, cy)
            ctx.lineTo(cx + 25, cy)
            ctx.closePath()
            ctx.fillStyle = "#c0c0c0"
            ctx.fill()

            ctx.textBaseline = "middle"
            ctx.textAlign = "center"
            ctx.font = "bold 40px 'Noto Serif'"
            ctx.fillStyle = "#000000"
            ctx.fillText(labels[i], cx, cy - 220)

            ctx.restore()
        }

        ctx.restore()
    }

    function drawPrimaryLabels(ctx) {
        ctx.save()

        const labels = ['N', 'E', 'S', 'W']
        const angles = [0, 90, 180, 270]

        for (var i = 0; i < 4; i++) {
            ctx.save()

            ctx.translate(cx, cy)
            ctx.rotate((angles[i]) / 180.0 * Math.PI)
            ctx.translate(-cx, -cy)

            ctx.beginPath()
            ctx.moveTo(cx, cy - 240)
            ctx.lineTo(cx - 25, cy)
            ctx.lineTo(cx + 25, cy)
            ctx.closePath()
            ctx.fillStyle = "#c0c0c0"
            ctx.fill()

            ctx.textBaseline = "middle"
            ctx.textAlign = "center"
            ctx.font = "bold 78px 'Noto Serif'"
            ctx.fillStyle = "#000000"
            ctx.fillText(labels[i], cx, cy - 300)

            ctx.restore()
        }

        ctx.restore()
    }

    function drawNumbers(ctx) {
        ctx.save()

        for (var angle = 0; angle < 360; angle += 20) {
            const text = angle.toString()
            ctx.save()
            ctx.translate(cx, cy)
            ctx.rotate((angle) / 180.0 * Math.PI)
            ctx.translate(-cx, -cy)
            ctx.textBaseline = "middle"
            ctx.textAlign = "center"
            ctx.font = "bold 48px 'Noto Serif'"
            ctx.fillStyle = "#303030"
            ctx.fillText(text, cx, 52)
            ctx.restore()
        }

        ctx.restore()
    }

    function drawTickmarks(ctx) {
        ctx.save()

        // Major tickmarks
        for (var angle = 10; angle < 360; angle += 20) {
            const text = angle.toString()
            ctx.save()
            ctx.translate(cx, cy)
            ctx.rotate((angle) / 180.0 * Math.PI)
            ctx.translate(-cx, -cy)
            ctx.fillStyle = "#303030"
            ctx.fillRect(cx, 70, 6, 60)
            ctx.restore()
        }

        // Medior tickmarks
        for (angle = 0; angle < 360; angle += 20) {
            const text = angle.toString()
            ctx.save()
            ctx.translate(cx, cy)
            ctx.rotate((angle) / 180.0 * Math.PI)
            ctx.translate(-cx, -cy)
            ctx.fillStyle = "#303030"
            ctx.fillRect(cx, 90, 3, 40)
            ctx.restore()
        }


        // Minor tickmarks
        for (angle = 5; angle < 360; angle += 10) {
            const text = angle.toString()
            ctx.save()
            ctx.translate(cx, cy)
            ctx.rotate((angle) / 180.0 * Math.PI)
            ctx.translate(-cx, -cy)
            ctx.fillStyle = "#303030"
            ctx.fillRect(cx, 100, 3, 30)
            ctx.restore()
        }

        ctx.restore()
    }
}
