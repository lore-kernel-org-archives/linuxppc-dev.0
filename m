Return-Path: <john.bonesio@xilinx.com>
Received: from outbound1-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 12AAC67A60
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 03:52:15 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: regarding xilinx system ace in linux-2.6
Date: Tue, 20 Jun 2006 10:30:27 -0700
Message-ID: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC01C80D81@XSJ-EXCHVS1.xlnx.xilinx.com>
From: "John Bonesio" <john.bonesio@xilinx.com>
To: "Jeff Angielski" <jeff@theptrgroup.com>, "rahul" <rahul.theraja@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Xilinx has contracted MontaVista to create an LSP for the ML40x
development boards for MVL Pro 4.0 (which uses the 2.6.10 kernel). This
work is nearing completion. We (Xilinx) have also asked MontaVista to
make those drivers available via open source, and MontaVista has agreed
to this.

The LSP is anticipated to be available sometime before the end of this
month. I'm not sure when the drivers will be made available to open
source.

Hope this helps,

- John



-----Original Message-----
From: linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org] On
Behalf Of Jeff Angielski
Sent: Wednesday, June 14, 2006 8:15 AM
To: rahul
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: regarding xilinx system ace in linux-2.6

On Wed, 2006-06-14 at 10:03 +0530, rahul wrote:
> Hi all
> I would like to know if anyone in the group or otherwise using
Xilinx's
> System ACE MPU interface to read/write to Compact Flash card on their
> hardware ?
> I came to know the code is implemented in linux-2.4  but i want to
have=20
> it in linux-2.6

Last I heard was that Xilinx was working on the linux 2.6
implementation. =20

You should contact your Xilinx representative to find out the current
status of that effort and/or where you can get the source code.


Jeff Angielski
The PTR Group

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
