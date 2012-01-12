Return-Path: <mremski@comcast.net>
Received: from qmta01.westchester.pa.mail.comcast.net
 (qmta02.westchester.pa.mail.comcast.net [76.96.62.24])
 by ozlabs.org (Postfix) with ESMTP id 51AA1B6EFE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2012 03:11:15 +1100 (EST)
Date: Thu, 12 Jan 2012 11:02:54 -0500 (EST)
From: Michael Remski <mremski@comcast.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: spi device from handle
Message-ID: <alpine.BSF.2.00.1201121056330.21456@payne.remski.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kernel 2.6.33

relevant section of dts has:
spi@7000 {
 	fpga0: fpga@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "fsl, espi-fpga";
 		reg = <0>;
 		linux,modalias = "spidev";
 		spi-max-frequency = <1572864>;
 	};
}


I have another device driver that needs to talk to this fpga device, but 
for the life of me I can't figure out the appropriate hooks to get there. 
The device can be talked to from userland via /dev/spixyx.k, but how do I 
get to the device from another driver?

Any little hints would be appreciated.  Upgrading kernel is not an option 
(sorry).

thanks

mike
