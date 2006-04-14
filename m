Return-Path: <Mike.Johnson@apc.com>
Received: from nammta.apcc.com (nammta.apcc.com [159.215.21.91])
	by ozlabs.org (Postfix) with ESMTP id 05424679F4
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 22:53:06 +1000 (EST)
Subject: Linux with CAN over SPI
To: linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Message-ID: <OFA3BE8291.CF7F1657-ON85257150.00446A1A-85257150.004564FA@apcc.com>
From: Mike.Johnson@apc.com
Date: Fri, 14 Apr 2006 08:37:58 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Mike.Johnson@apc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


All,

I'm looking for some information about a CAN driver and how it might
nterface to an SPI port of the PPC 875 processor.

I am new to the linux world and am trying to write a CAN device driver that
uses SPI to communicate to the external CAN chip.

The latest kernel has some CAN and SPI support. I am beginning to put some
of the pieces together on how these work, but It's new to me how these are
truly instantiated and implemented in the kernel.

Does anyone know of a white paper or any documentation that may explain the
general process of a network device driver installation? (I do know that
the CAN driver is considered a network interface, not a "char" or "block"
interface.)

What is the order of steps to initialize the SPI driver? I'm guessing the
SPI driver need to be initialized before it can detect the presents of the
CAN chip.

Does the CAN driver try to talk to the CAN chip via SPI to determine its
existance?

These are the questions I'm hoping to fill in.

I have been reading the O'reilly book on device drivers...this helps
some.....but any other real world help would be appreciated.

Thank-you,

Mike

Michael Johnson
American Power Conversion
132 Fairgrounds Road
West Kingston, RI  02892
tele: (401) 789 - 5735 x2982


http://www.apc.com
http://www.netbotz.com
http://www.datacenteruniversity.com
