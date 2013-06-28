Return-Path: <zhao.xia@nsn.com>
Received: from demumfd001.nsn-inter.net (demumfd001.nsn-inter.net
 [93.183.12.32])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "demumfd001.nsn-inter.net",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 932CD2C0382
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 18:33:02 +1000 (EST)
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
 by demumfd001.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id
 r5S8Q14Z018186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 10:26:01 +0200
Received: from SGSIHTC004.nsn-intra.net ([10.159.225.21])
 by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id
 r5S8NlWe004189
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 10:26:00 +0200
From: "Xia, Zhao (NSN - CN/Shanghai)" <zhao.xia@nsn.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: FW: crash dump on ppc linux
Date: Fri, 28 Jun 2013 08:24:31 +0000
Message-ID: <7099B9A8CC7DCE4BA6769EB527DC640C048B3D@SGSIMBX005.nsn-intra.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

Could you help to confirm:
Kexec-tools 2.0.4 + Linux 2.6.33 on MPC8541(PPC32) can work or not?
If not, how to make it? Thanks a lot.


-----Original Message-----
From: ext Simon Horman [mailto:horms@verge.net.au]=20
Sent: Friday, June 28, 2013 4:17 PM
To: Xia, Zhao (NSN - CN/Shanghai)
Subject: Re: crash dump on ppc linux

On Wed, Jun 26, 2013 at 05:12:21AM +0000, Xia, Zhao (NSN - CN/Shanghai) wro=
te:
> Hi  Horms
>=20
> I visted the kexec-tool project page : http://horms.net/projects/kexec/ke=
xec-tools/README.html
> and I am glad to know that you are the maintainer of kexec-tools. Could y=
ou help to answer the following question?
>=20
> 1)      Does kexec-2.0.3 support ppc Linux (not ppc64 Linux)?  Because I =
am debugging with mpc8541(PPC arch) on Linux 2.6.33.
>       And I encountered some problem.
> 2)      Does the Linux version 2.6.33 need some patch for kexec-tools?

Hi,

I think these questions would be best sent to the
linuxppc-dev@lists.ozlabs.org and kexec@lists.infradead.org lits.

In general I believe that ppc64 is supported by kexec-tools 2.0.3 + 2.6.33.
However, I am not familiar with mpc8541 and there are ongoing improvements
made to ppc64 support for both kexec-tools and the linux kernel.  So if
possible I would try using newer versions - the latest version of
kexec-tools is 2.0.4. And in the case of kexec-tools
the current git branch if the latest release seems to not work.

git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
