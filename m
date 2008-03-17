Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 10AFCDE15C
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 07:59:58 +1100 (EST)
To: "Grant Likely" <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Please pull linux-2.6-mpc52xx.git
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 17 Mar 2008 13:19:44 CST."
	<fa686aa40803171219s7135a0f8n91bcd20329a94637@mail.gmail.com>
Date: Mon, 17 Mar 2008 21:59:56 +0100
Sender: wd@denx.de
Message-Id: <20080317205956.BAC85241A2@gemini.denx.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <fa686aa40803171219s7135a0f8n91bcd20329a94637@mail.gmail.com> you wrote:
>
> >  What is the status of the various MPC5200-related patches (support for
> >  TQM5200, CM5200 and Motion-PRO boards, few drivers, etc) posted some
> >  time ago by Marian Balakowicz? There's been some comments to the patches
> >  on the list, which were addressed and no further discussion occurred, so
> >  we were hoping that the changes would go upstream (in 2.6.25). I can see
> >  that the .dts files for those boards are in the mainline already, but I
> >  see no trace of for example _defconfig files -- could you shed some
> >  light on this?
> 
> Yes, the separate dts files have been dropped in preference for a
> single mpc5200_defconfig for all 5200 boards.

I know that my opinion doesn't matter but that's a  stupid  thing  to
do. Do you think that this single mpc5200_defconfig will (a) work and
(b)  be  useful  on all 5200 boards? Who hast tested it, and on which
platforms?

And what about the other patches? I see no code for these boards in
arch/powerpc/platforms/52xx/ ?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Minds are like parachutes - they only function when open.
