Message-ID: <8D4C69676E66D511A1CB00508BBBB1921BCF0E@ranmx1.ran.harris.com>
From: "Walser, Martin" <mwalser@harris.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: enet rx doesn't work 
Date: Wed, 13 Mar 2002 05:03:59 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've tested the rx clock routing, this is ok.
All other signals seem to be ok (COL is low, CD is high when receiving a frame).

So I don't know what should be wrong.

That's the configuration of my board.

/* Bits in parallel I/O port registers that have to be set/cleared
 * to configure the pins for SCC2 use.
 */
#define PA_ENET_RXD	((ushort)0x0004)	/* PA 13 */
#define PA_ENET_TXD	((ushort)0x0008)	/* PA 12 */
#define PA_ENET_RCLK	((ushort)0x0400)	/* PA  5 */
#define PA_ENET_TCLK	((ushort)0x0800)	/* PA  4 */

#define PC_ENET_TENA	((ushort)0x0002)	/* PC 14 */
#define PC_ENET_CLSN	((ushort)0x0040)	/* PC 9 */
#define PC_ENET_RENA	((ushort)0x0080)	/* PC 8 */

/* Control bits in the SICR to route TCLK (CLK4) and RCLK (CLK3) to
 * SCC2.  Also, make sure GR2 (bit 16) and SC2 (bit 17) are zero.
 */
#define SICR_ENET_MASK	((uint)0x0000ff00)
#define SICR_ENET_CLKRT	((uint)0x00003700)


Best regards
Martin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
