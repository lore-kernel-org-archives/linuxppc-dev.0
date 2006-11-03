Return-Path: <christophe.alayrac@cresitt.com>
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by ozlabs.org (Postfix) with ESMTP id 1ACD267CDE
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Nov 2006 03:14:35 +1100 (EST)
Received: from CRESITTLAB (sou45-1-82-229-118-71.fbx.proxad.net
	[82.229.118.71])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C89304A17F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Nov 2006 17:14:33 +0100 (CET)
From: "alayrac" <christophe.alayrac@cresitt.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE : minor progress with plb_temac v3.00a, EDK 8.2, & 2.6.18.1
Date: Fri, 3 Nov 2006 17:14:21 +0100
Message-ID: <000001c6ff63$1f80fcb0$c900a8c0@CRESITTLAB>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Robert,

Thanks for your contribution.
I would like to know where did you get the kernel source 2.6.18.1?

I've tried from kernel.org, but then temac drivers is not included.
I've then download the temac patch from mvista at following address :
http://source.mvista.com/~ank/paulus-powerpc/20060309/temac.paulus-power
pc.20060309.tgz

When I try to pacth the kernel with following command :
	patch -i ppc32_xilinx_edk_temac.patch
the process ask me the file to pacth.

I've try to get the kernel source code from mvista with cg-clone
commande from 
cg-clone git://source.mvista.com/git/linux-xilinx-26.git 

and patch command give same message.

Any track to properly applying patch?

Kinds regards

Chris

CRESITT INDUSTRIE
12 Rue de Blois, BP6744
45067 ORLEANS Cedex 2
Tel : 02.38.49.45.59
Fax :02.38.49.45.55
Email : christophe.alayrac@cresitt.com 
Web : http://www.cresitt.com
