Return-Path: <r66093@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3FCAB2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 16:18:12 +1000 (EST)
From: Huang Changming-R66093 <r66093@freescale.com>
To: Chris Ball <cjb@laptop.org>, Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
Date: Wed, 12 Sep 2012 06:18:01 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C17701A@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
 <20120911075429.GA27028@lizard> <20120911080457.GA28235@lizard>
 <110EED8CC96DFC488B7E717A2027A27C176170@039-SN1MPN1-002.039d.mgd.msft.net>
 <6D8C87BA-CA06-4215-94F5-63EBF5162B0A@kernel.crashing.org>
 <2A6FCAE3-288F-4972-90C0-15105932F13E@kernel.crashing.org>
 <87k3w0y5yn.fsf@octavius.laptop.org>
 <FC22FA36-B2CF-49C2-A0B1-8A0EA614B9CB@kernel.crashing.org>
 <87liggwa1w.fsf@octavius.laptop.org>
In-Reply-To: <87liggwa1w.fsf@octavius.laptop.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Anton Vorontsov <cbouatmailru@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Best Regards
Jerry Huang


> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Wednesday, September 12, 2012 4:59 AM
> To: Kumar Gala
> Cc: Huang Changming-R66093; linuxppc-dev@lists.ozlabs.org list; linux-
> mmc@vger.kernel.org; Anton Vorontsov
> Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
>=20
> Hi,
>=20
> On Tue, Sep 11 2012, Kumar Gala wrote:
> > thanks for the info.  Do you know what's required on controller side
> > to handle cards that support CMD23?
> >
> > I'm trying to figure out if older controller's on FSL SoCs are missing
> > some feature to allow CMD23 to work (vs Auto-CMD23).
>=20
> It seems plausible that it's just not implemented on these controllers.
> It's a little strange, since the command's been specified for so long and
> we haven't seen any other controllers with problems.  The patch would be
> correct if this is true.
>=20

I didn't find any description about it, but after testing on FSL silicones,=
 I got this result:
Some silicones support this command, and some silicones don't support it, w=
hich will cause I/O error.
