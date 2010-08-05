Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
	[208.65.175.196]) by ozlabs.org (Postfix) with ESMTP id 68EFAB70AB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Aug 2010 23:03:35 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, Grant Likely
	<grant.likely@secretlab.ca>
Date: Thu, 5 Aug 2010 08:59:57 -0400
Subject: RE: [PATCH 0/2 v3] mpc5200 ac97 gpio reset
Message-ID: <0A40042D85E7C84DB443060EC44B3FD325420B9123@dekaexchange07.deka.local>
References: <1276617907-10862-1-git-send-email-emillbrandt@dekaresearch.com>
	<20100622230026.GA2453@opensource.wolfsonmicro.com>
	<AANLkTiluyeGSwVSXgTeRxS3hVWTe3Gkn8qHrqbHJFMun@mail.gmail.com>
	<D37786F8-EBA7-4E55-AE83-5D0ABF1E17BF@opensource.wolfsonmicro.com>
	<AANLkTikbHp18uc-idFtEqakoo_0Vdg_rU44xv9uHwkvG@mail.gmail.com>
	<20100803055216.GA25306@rakim.wolfsonmicro.main>
In-Reply-To: <20100803055216.GA25306@rakim.wolfsonmicro.main>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+emillbrandt=3Ddekaresearch.com@lists.ozlabs.or=
g
> [mailto:linuxppc-dev-
> bounces+emillbrandt=3Ddekaresearch.com@lists.ozlabs.org] On Behalf Of Mar=
k
> Brown
> Sent: Tuesday, August 03, 2010 01:52
> To: Grant Likely
> Cc: linuxppc-dev@lists.ozlabs.org; Eric Millbrandt
> Subject: Re: [PATCH 0/2 v3] mpc5200 ac97 gpio reset
>
> On Sat, Jul 31, 2010 at 10:42:15PM -0600, Grant Likely wrote:
> > On Sun, Jun 27, 2010 at 4:01 PM, Mark Brown
>
> > > I'm a little concerned with a collision with multi codec here. It'd
> > > be handy if you could keep it separate in case it needs merging
> > > into both trees (or we could merge via ASoC only).
>
> > Hmmm.  Yeah, probably better to take it via your tree then.  I've
> > currently got patch 1 in linux-next, but I'll drop it before asking
> > benh to pull.  Go ahead and add my acked-by.
>
> Looks like multi-component is slightly too late for .36 and I don't have
> the original patch any more since it looked like you were going to be
> carrying it...  could you restore the patch to your tree please?

<ping> Grant, are you going to pick up this series for .36?

Eric

-DISCLAIMER: an automatically appended disclaimer may follow. By posting-
-to a public e-mail mailing list I hereby grant permission to distribute-
-and copy this message.-

This e-mail and the information, including any attachments, it contains are=
 intended to be a confidential communication only to the person or entity t=
o whom it is addressed and may contain information that is privileged. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that any dissemination, distribution or copying of this communication=
 is strictly prohibited. If you have received this communication in error, =
please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
