Return-Path: <linnj@xilinx.com>
Received: from SG2EHSOBE006.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 4B0BCDDDE3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Oct 2008 03:11:36 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: needhelp to install linux 2.6 on ppc405 of a virtex II pro
Date: Wed, 29 Oct 2008 10:08:59 -0600
In-Reply-To: <20218592.post@talk.nabble.com>
References: <883498565@web.de> <20218592.post@talk.nabble.com>
From: John Linn <linnj@xilinx.com>
To: "saadia" <saadia_dhouib@yahoo.fr>,
	<linuxppc-embedded@ozlabs.org>
Message-ID: <20081029161129.5E8AF1808056@mail4-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We don't directly support the V2Pro, but we do support the Virtex 4
which also uses the ppc405 in the Xilinx GIT Tree.

git://git.xilinx.com
http://git.xilinx.com

You should make sure that you use arch/powerpc rather than arch/ppc
which many older web sites have tutorials about. Arch/ppc is not longer
supported.

You can find more information about this at http://xilinx.wikidot.com

This information assumes you already know Xilinx products and is not a
tutorial on all Xilinx products.  It also assumes you know Linux so it
is really the Xilinx unique aspects of the kernel/BSP.

We've now created a forum for Embedded Linux at Xilinx at the following
location.

http://forums.xilinx.com

Thanks,
John

> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of saadia
> Sent: Tuesday, October 28, 2008 6:00 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: needhelp to install linux 2.6 on ppc405 of a virtex II pro
> =

> =

> Hi
> I want to install linux 2.6 on a ppc405 of a virtex II pro, and then
patch
> it with rtai or xenomai. Is there some tutorial explaining the
installation
> procedure (where to find sources, drivers etc).
> I have found this link:
> http://users.telenet.be/steven.kauffmann/installation/index.htm
> but it concerns linux 2.4;
> Can anyone help me to find useful links or documents to install the
2.6
> kernel whith a real time extension?
> Thanks
> =

> --
> View this message in context:
http://www.nabble.com/use-xilinx-gpio-from-linux-on-a-ppc405-
> tp18507061p20218592.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
> =

> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
