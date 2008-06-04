Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18502.5368.786188.835122@cargo.ozlabs.ibm.com>
Date: Wed, 4 Jun 2008 14:07:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/8 v4] mpc83xx_wdt rework, support for mpc8610 and mpc8xx
In-Reply-To: <20080603173214.0bf71571.akpm@linux-foundation.org>
References: <20080602173726.GA24556@polina.dev.rtsoft.ru>
	<20080603164830.32457962.akpm@linux-foundation.org>
	<20080604001739.GB24548@polina.dev.rtsoft.ru>
	<20080603173214.0bf71571.akpm@linux-foundation.org>
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	wim@iguana.be, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton writes:

> On Wed, 4 Jun 2008 04:17:39 +0400
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > > Please put the subsystem identifier (eg, "watchdog" and "powerpc")
> > > outside the [], for reasons which should be in
> > > Documentation/SubmittingPatches, which used to be there but which got
> > > lost.  Bascially the text inside [] is for temporary not-for-committing
> > > information such as "rfc", "2.6.24-rc4", "resend", etc and should be stripped
> > > by the email recipient before merging.
> > 
> > Yeah, I know. It is just hard to remember all the preferences.
> > 
> > For example, PowerPC maintainers asking to do patches with "[POWERPC]"
> > identifier, this identifier purposely keeps intact for git-log.
> 
> Addition of "[powerpc]" if it was absent can be scripted.
> 
> However, the retaining of "[powerpc]" (etc) while not retaining "[rfc]"
> (etc) is not practical.
> 
> Plus putting things into git with "[powerpc]" in the title is wrong. 
> The chances are good that anyone who is taking such a patch off the
> git-commits list (say, for a backport) will lose that part of the
> title.  It should be "powerpc: "

I think Anton is confusing two things: (a) what should be in the
subject line of a patch posted to a mailing list, and (b) what should
be in the headline of a commit put into a git tree that I pull from.
As for (a), people can put whatever they like in [], and if people put
"powerpc:" in the subject, I edit it out since my scripts put
[POWERPC] in the git commit headline.  For (b), I ask git tree
maintainers that I'm going to pull from to put [POWERPC] at the start
of the headline for consistency with what I do.

Looking at Linus' git tree, it's evident that some subsystems use the
the "[SUBSYSTEM]" notation and some use "subsystem:".  If there is now
an edict from on high that only "subsystem:" is acceptable, then I
must have missed that memo.

Paul.
