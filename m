Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910805272001r4bd28cccl3f7b41d9ff476a81@mail.gmail.com>
Date: Tue, 27 May 2008 23:01:50 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "linuxppc-dev list" <Linuxppc-dev@ozlabs.org>
Subject: Bestcomm and AC97
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm playing around with a Alsa SOC driver for the Efika. The Efika
uses a STAC9266 for AC97 which supports simultaneous SPDIF and analog
output. To do this the PSC needs DMA data from two different buffers
interleaved and placed into its FIFO. Is this something Bestcomm can
do?

Examples
mono + spdif = 1 sample from buffer one, two from buffer two
stereo + spdif = 2 samples from buffer one, two from buffer two
clone the output, 2 samples from buffer one, write to FIFO twice

When only spdif or analog is used standalone the existing generic task works.

-- 
Jon Smirl
jonsmirl@gmail.com
