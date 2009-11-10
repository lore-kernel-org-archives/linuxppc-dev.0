Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 60F90B7BBD
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 09:22:49 +1100 (EST)
In-Reply-To: <4AF9C647.50600@freescale.com>
References: <1257341920-29277-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091106003305.GA15814@loki.buserror.net>
	<OF2C4359C9.0EB89938-ONC1257666.00299975-C1257666.002C206F@transmode.se>
	<OFBF62CE94.BC53D847-ONC1257666.0033CF65-C1257666.0034293A@transmode.se>
	<20091109215321.GA4351@loki.buserror.net>
	<20091109230004.GA24671@loki.buserror.net>
	<OFB7406DC7.1C857967-ONC125766A.006CC82E-C125766A.006D53DA@transmode.se>
	<4AF9C647.50600@freescale.com>
Subject: Re: [PATCH 0/8] 8xx: Misc fixes for buggy insn
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OFA418F288.1A30C1E7-ONC125766A.007396A9-C125766A.0073E1EC@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 10 Nov 2009 22:05:44 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 10/11/2009 21:00:07:
>
> Joakim Tjernlund wrote:
> > I think I have misunderstood, its is not CPU15 or 8xx problem per se, it
> > is a general problem that could happen to any ppc CPU, right?
> > 8xx just happen to be the first CPU that hits this case due to my
> > DAR fixing
>
> Is there any chip other than 8xx where the kernel text is not always pinned?

No idea, something for the list to comment on.
But if so 8xx should do the same(at least for ITLB), there is
no other way to guarantee this problem won't happen I think.

 Jocke
