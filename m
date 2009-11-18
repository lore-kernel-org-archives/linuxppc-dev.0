Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9BFEFB6F0C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Nov 2009 10:10:06 +1100 (EST)
In-Reply-To: <4B046E02.9030606@freescale.com>
References: <1258304977-11760-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091116210009.GA5113@loki.buserror.net>
	<20091116212741.GA10968@loki.buserror.net>
	<OF8A8D1539.83855DA3-ONC1257670.007D4AD1-C1257670.007DC74A@transmode.se>
	<4B01F0EB.70707@freescale.com>
	<OF735CB2F5.65B4E3F3-ONC1257671.002BB41C-C1257671.002C5E4F@transmode.se>
	<4B046248.7060101@freescale.com>
	<OFD94AE350.813F1695-ONC1257672.007719B8-C1257672.00778BD4@transmode.se>
	<4B046E02.9030606@freescale.com>
Subject: Re: [PATCH 00/10] Fix 8xx MMU/TLB
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OFAFE1DE56.4C34F334-ONC1257672.007E8F4C-C1257672.007ED46B@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 19 Nov 2009 00:05:19 +0100
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

Scott Wood <scottwood@freescale.com> wrote on 18/11/2009 22:58:26:
>
> Joakim Tjernlund wrote:
> > Yeah, those are the ones that will trigger a dcbX TLB fault,
> > copy_tofrom_user would be my guess. Perhaps I missed something
> > in the conversions? That is, maybe some of these routines are plain wrong now for
> > 8xx due to some other bug?
> > A small test program in user space doing some dcbX insn could shed some light?
>
> Sorry, it looks like the rlwimi instruction I gave you was bad.
>
> It should be:
> rlwimi  r11, r10, 12, 0xffc
> instead of:
> rlwimi  r11, r10, 22, 0xffc

ah, great. You have no issues now?

I will fix and resubmit in a day or so.

Rex, were did you go? I have not heard from you for quite some time.

 Jocke
