Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B69AADDE40
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 23:22:00 +1100 (EST)
To: Vitaly Bordug <vitb@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 1/1] [PPC] 8xx swap bug-fix
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 05 Feb 2008 01:38:57 +0300."
	<20080205013857.47ebe544@kernel.crashing.org>
Date: Thu, 21 Feb 2008 13:21:58 +0100
Sender: wd@denx.de
Message-Id: <20080221122158.11BB324D16@gemini.denx.de>
Cc: dzu@denx.de, linuxppc-dev@ozlabs.org, Mackerras <paulus@samba.org>,
	Paul@ozlabs.org, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Vitaly,

in message <20080205013857.47ebe544@kernel.crashing.org> you wrote:
> On Mon, 4 Feb 2008 12:24:21 -0600
> Scott Wood wrote:
> 
> > On Sat, Feb 02, 2008 at 12:22:17PM +0100, Jochen Friedrich wrote:
> > > Hi Yuri,
> > > 
> > > >  Here is the patch which makes Linux-2.6 swap routines operate
> > > > correctly on the ppc-8xx-based machines.
> > > 
> > > is there any 8xx board left which isn't ported to ARCH=powerpc?
> > 
> > More importantly, is this something that is also broken in
> > arch/powerpc?  It looks like it has the same code...
> > 
> yes, it is. Though there is currently no best-at-all solution, this looks worth trying.
> I'll have a look how the 8xx feels under load and report back.

Have you been able to check if arch/powerpc needs similar fixing?


Also, what is the current state of this patch? I would like to avoid
that it get's lost completeley.


BenH commented on Tue, 05 Feb 2008 18:37:07 +1100:

> Best is to just remove writeback completely and let the generic
> code handle it.

Has this been considered / tested by anybody?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Man did not weave the web of life; he  is  merely  a  strand  in  it.
Whatever he does to the web, he does to himself.     - Seattle [1854]
