
   /*
    * Copyright 2012 The Netty Project
    *
    * The Netty Project licenses this file to you under the Apache License,
    * version 2.0 (the "License"); you may not use this file except in compliance
    * with the License. You may obtain a copy of the License at:
    *
    *   http://www.apache.org/licenses/LICENSE-2.0
    *
   * Unless required by applicable law or agreed to in writing, software
   * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
   * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
   * License for the specific language governing permissions and limitations
   * under the License.
   */
 package exam.echo;
  
  import io.netty.buffer.ByteBuf;
  import io.netty.buffer.Unpooled;
  import io.netty.channel.ChannelHandlerContext;
  import io.netty.channel.ChannelInboundHandlerAdapter;
  import io.netty.util.ReferenceCountUtil ;
  
  /**
   * Handler implementation for the echo client.  It initiates the ping-pong
   * traffic between the echo client and server by sending the first message to
   * the server.
   */
  public class EchoClientHandler extends ChannelInboundHandlerAdapter {
  
      private final ByteBuf firstMessage;
  
      /**
       * Creates a client-side handler.
       */
      public EchoClientHandler(String inData) {
          firstMessage = Unpooled.buffer(EchoClient.SIZE);
          for (int i = 0; i < firstMessage.capacity()-1; i ++) {
              firstMessage.writeByte((byte) inData.charAt((int)i%inData.length()));
          }
      }
  
      @Override
      public void channelActive(ChannelHandlerContext ctx) {
          ctx.writeAndFlush(firstMessage);
      }
  
      @Override
      public void channelRead(ChannelHandlerContext ctx, Object msg) {
			ctx.write(msg);


			ByteBuf in = (ByteBuf) msg;
			try 
			{
				System.out.print("\r\n**** recvd ****** {{\r\n");
				while (in.isReadable()) 
				{ // (1)
					System.out.print((char) in.readByte());
					System.out.flush();
				}
				System.out.print("\r\n**** recvd ****** }}\r\n");
			} 
			finally 
			{
				//ReferenceCountUtil.release(msg); // (2)
				
			}
			
			
      }
  
      @Override
      public void channelReadComplete(ChannelHandlerContext ctx) {
         ctx.flush();
      }
  
      @Override
      public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) {
          // Close the connection when an exception is raised.
          cause.printStackTrace();
          ctx.close();
      }
  }
