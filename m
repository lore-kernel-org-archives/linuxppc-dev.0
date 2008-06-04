Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5F841DDE16
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 22:27:27 +1000 (EST)
Date: Wed, 4 Jun 2008 16:27:25 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/8 v4] mpc83xx_wdt rework, support for mpc8610 and mpc8xx
Message-ID: <20080604122725.GB2281@polina.dev.rtsoft.ru>
References: <20080602173726.GA24556@polina.dev.rtsoft.ru>
	<20080603164830.32457962.akpm@linux-foundation.org>
	<20080604001739.GB24548@polina.dev.rtsoft.ru>
	<20080603173214.0bf71571.akpm@linux-foundation.org>
	<18502.5368.786188.835122@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <18502.5368.786188.835122@cargo.ozlabs.ibm.com>
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	wim@iguana.be, scottwood@freescale.com,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 04, 2008 at 02:07:20PM +1000, Paul Mackerras wrote:
> Andrew Morton writes:
> 
> > On Wed, 4 Jun 2008 04:17:39 +0400
> > Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> > 
> > > > Please put the subsystem identifier (eg, "watchdog" and "powerpc")
> > > > outside the [], for reasons which should be in
> > > > Documentation/SubmittingPatches, which used to be there but which got
> > > > lost.  Bascially the text inside [] is for temporary not-for-committing
> > > > information such as "rfc", "2.6.24-rc4", "resend", etc and should be stripped
> > > > by the email recipient before merging.
> > > 
> > > Yeah, I know. It is just hard to remember all the preferences.
> > > 
> > > For example, PowerPC maintainers asking to do patches with "[POWERPC]"
> > > identifier, this identifier purposely keeps intact for git-log.
> > 
> > Addition of "[powerpc]" if it was absent can be scripted.
> > 
> > However, the retaining of "[powerpc]" (etc) while not retaining "[rfc]"
> > (etc) is not practical.
> > 
> > Plus putting things into git with "[powerpc]" in the title is wrong. 
> > The chances are good that anyone who is taking such a patch off the
> > git-commits list (say, for a backport) will lose that part of the
> > title.  It should be "powerpc: "
> 
> I think Anton is confusing two things: 

I found original email.. yes, you indeed ask for [POWERPC] in git
trees.

But. I believe anyone who send patches, tries to mimic existing practice,
and thus please the maintainer. Personally, I'm doing git log subsystem/
and looking for the preferred format for the commit message. And I'm not
alone: linuxppc-dev is full of [POWERPC] in the patch subjects, despite
the fact that you didn't explicitly ask for it.

Asking to send patches with "subsystem: " and then seeing them as
"[SUBSYSTEM] " in git-log is more confusing. Since new authors will
personalize this thinking: "Oh, maintainer fixed my negligence.
Next time I should send a patch with [SUBSYSTEM]".

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
