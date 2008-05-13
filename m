Return-Path: <John.Linn@xilinx.com>
Received: from outbound7-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A9EE3DDF05
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 May 2008 23:42:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linux on Ml410
Date: Tue, 13 May 2008 07:42:11 -0600
In-Reply-To: <016601c8b4ed$a56e57a0$f04b06e0$@com>
References: <016601c8b4ed$a56e57a0$f04b06e0$@com>
From: "John Linn" <John.Linn@xilinx.com>
To: "mojtaba" <kernelppc@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080513134214.1A6671970046@mail123-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Mojtaba,

Did you build the FPGA bit stream yourself or get it from somewhere?

Specifying ttyS0 means you should have a 16550 UART in the hardware
build, do you?

-- John

-----Original Message-----
From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of mojtaba
Sent: Tuesday, May 13, 2008 5:37 AM
To: linuxppc-embedded@ozlabs.org
Subject: Linux on Ml410

Dear all,

I am trying to run linux 1.6.25 on ML410 board. When the system boot I
receive this error:

loaded at:     00400000 004CD19C
board data at: 004CB120 004CB19C
relocated to:  00404050 004040CC
zimage at:     00404E3C 004CA0D1
avail ram:     004CE000 10000000

Linux/PPC load: console=3DttyS0,115200 root=3D/dev/xsa2
Uncompressing Linux...inflate returned FFFFFFFD
exit

I will appreciate it if somebody can kindly answer me?
Regards,
Mojtaba

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
