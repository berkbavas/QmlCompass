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

        drawOuterBorder(ctx)
        drawNumbers(ctx)
        drawInnerBorder(ctx)
        drawLines(ctx)
        drawInnerCircle(ctx)
        drawPrimaryLabels(ctx)
        drawSecondaryLabels(ctx)
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
        ctx.lineTo(cx, 45)
        ctx.lineTo(cx - 30, cy)
        ctx.closePath()
        ctx.fillStyle = redGradient
        ctx.fill()

        // Blue
        const blueGradient = ctx.createLinearGradient(cx - 30, 0, cx + 30, 0)
        blueGradient.addColorStop(0, "#3465A4")
        blueGradient.addColorStop(1, "#1b3c6a")

        ctx.beginPath()
        ctx.moveTo(cx, cy)
        ctx.arc(cx, cy, 45, Math.PI, 0, true)
        ctx.closePath()
        ctx.fillStyle = blueGradient
        ctx.fill()

        ctx.beginPath()
        ctx.moveTo(cx + 30, cy)
        ctx.lineTo(cx, 2 * cy - 57.5)
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
            ctx.moveTo(cx, cy - 260)
            ctx.lineTo(cx - 25, cy)
            ctx.lineTo(cx + 25, cy)
            ctx.closePath()
            ctx.fillStyle = "#afc6c5"
            ctx.fill()

            ctx.textBaseline = "middle"
            ctx.textAlign = "center"
            ctx.font = "48px 'Noto Serif'"
            ctx.fillStyle = "#000000"
            ctx.fillText(labels[i], cx, cy - 290)

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
            ctx.moveTo(cx, cy - 330)
            ctx.lineTo(cx - 25, cy)
            ctx.lineTo(cx + 25, cy)
            ctx.closePath()
            ctx.fillStyle = "#afc6c5"
            ctx.fill()

            ctx.textBaseline = "middle"
            ctx.textAlign = "center"
            ctx.font = "96px 'Noto Serif'"
            ctx.fillStyle = "#000000"
            ctx.fillText(labels[i], cx, cy - 350)

            ctx.restore()
        }

        ctx.restore()
    }

    function drawLines(ctx) {
        ctx.save()

        ctx.translate(cx, cy)
        ctx.rotate(22.5 / 180.0 * Math.PI)
        ctx.translate(-cx, -cy)

        for (var angle = 0.0; angle < 360; angle += 45) {
            ctx.translate(cx, cy)
            ctx.rotate((angle) / 180.0 * Math.PI)
            ctx.translate(-cx, -cy)

            ctx.beginPath()
            ctx.moveTo(cx, 90)
            ctx.lineTo(cx, cy)

            ctx.strokeStyle = "#e0e0e0"
            ctx.lineWidth = 3
            ctx.stroke()
        }

        ctx.restore()
    }

    function drawInnerCircle(ctx) {
        ctx.save()

        ctx.beginPath()
        ctx.arc(cx, cy, outerRadius - 180, 0, 2 * Math.PI)
        ctx.strokeStyle = "#e0e0e0"
        ctx.lineWidth = 2
        ctx.stroke()

        ctx.restore()
    }

    function drawInnerBorder(ctx) {
        ctx.save()
        ctx.beginPath()
        ctx.arc(cx, cy, outerRadius - 70, 0, 2 * Math.PI)
        ctx.arc(cx, cy, outerRadius - 90, 2 * Math.PI, 0)
        ctx.fillStyle = "#e0e0e0"
        ctx.fill()
        ctx.restore()
    }

    function drawNumbers(ctx) {
        ctx.save()

        for (var angle = 0; angle < 360; angle += 10) {
            const text = angle.toString()
            ctx.save()
            ctx.translate(cx, cy)
            ctx.rotate((angle) / 180.0 * Math.PI)
            ctx.translate(-cx, -cy)
            ctx.textBaseline = "middle"
            ctx.textAlign = "center"
            ctx.font = "27px 'Noto Serif'"
            ctx.fillStyle = "#303030"
            ctx.fillText(text, cx, 52)
            ctx.restore()
        }

        ctx.restore()
    }

    function drawOuterBorder(ctx) {
        ctx.save()

        const outerBorderColor = "#000000"
        const borderWidth = 5
        const borderHeight = 24

        const innerRadius = outerRadius - borderHeight
        ctx.strokeStyle = outerBorderColor
        ctx.lineWidth = borderWidth

        ctx.beginPath()
        ctx.arc(cx, cy, outerRadius - 0.5 * borderWidth, 0, 2 * Math.PI)
        ctx.closePath()
        ctx.stroke()

        ctx.beginPath()
        ctx.arc(cx, cy, innerRadius - 0.5 * borderWidth, 0, 2 * Math.PI)
        ctx.closePath()
        ctx.stroke()

        ctx.beginPath()

        for (var angle = 0; angle < 360; angle += 2) {
            ctx.save()
            ctx.translate(cx, cy)
            ctx.rotate((angle / 180.0) * Math.PI)
            ctx.moveTo(cx - 0, 0)
            ctx.lineTo(cx - borderHeight, 0)
            ctx.restore()
        }

        ctx.strokeStyle = "#000000"
        ctx.lineWidth = borderWidth
        ctx.stroke()

        ctx.restore()
    }
}
