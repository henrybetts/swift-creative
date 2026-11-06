import WebGPU

/// A 2D scene.
@MainActor
public final class Scene2D {
    /// The color the scene is cleared to before it's drawn.
    public var backgroundColor = Color.black

    /// Creates an empty scene.
    public init() {}

    /// Encodes and submits the commands that draw the scene to `view`.
    func draw(to view: TextureView) {
        let device = Device.default.device
        let encoder = device.createCommandEncoder()
        let renderPass = encoder.beginRenderPass(descriptor: RenderPassDescriptor(colorAttachments: [
            RenderPassColorAttachment(
                view: view,
                loadOp: .clear,
                storeOp: .store,
                clearValue: WebGPU.Color(backgroundColor))
        ]))
        renderPass.end()
        device.queue.submit(commands: [encoder.finish()])
    }
}
