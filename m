Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3776C2C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 10:11:07 +1000 (EST)
Date: Mon, 17 Jun 2013 19:10:53 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc/pci: Fix setup of Freescale PCI / PCIe
 controllers
To: Rojhalat Ibrahim <imr@rtschenk.de>
References: <1371241083.2996.7@snotra> <2435509.QyTW5GJC53@pcimr>
In-Reply-To: <2435509.QyTW5GJC53@pcimr> (from imr@rtschenk.de on Mon Jun 17
 08:15:33 2013)
Message-ID: <1371514253.9073.8@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Guntsche <michael.guntsche@it-loops.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2013 08:15:33 AM, Rojhalat Ibrahim wrote:
> On Friday 14 June 2013 15:18:03 Scott Wood wrote:
> > On 83xx:
> > cc1: warnings being treated as errors
> > =20
> /home/scott/fsl/git/linux/upstream/arch/powerpc/sysdev/fsl_pci.c:100:23:
> > error: 'fsl_indirect_pcie_ops' defined but not used
> > make[2]: *** [arch/powerpc/sysdev/fsl_pci.o] Error 1
> > make[2]: *** Waiting for unfinished jobs....
> >
> > I can fix this when applying, but this makes me wonder how you =20
> tested
> > it, given that the whole point is to fix 83xx...  Did you fix this =20
> and
> > then accidentally sent a stale version?
> >
> > Also, please be careful that the patch doesn't get line wrapped -- I
> > had to manually unwrap a couple places.  Use git send-email if you
> > can't get KMail to cooperate.
> >
> > -Scott
>=20
> Sorry about the mess. I'll send a v3.
> Please note: I don't have an 83xx system. So I can only test if it =20
> compiles,
> which I obviously did not do with the right config.

OK, so it looks like it was Michael who ran into the problem on 83xx.  =20
Michael, could you test the v3 patch that Rojhalat posted?

-Scott=
