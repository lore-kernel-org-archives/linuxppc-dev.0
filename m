Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B47D4DDF5C
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 10:17:42 +1000 (EST)
Date: Wed, 4 Jun 2008 04:17:39 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/8 v4] mpc83xx_wdt rework, support for mpc8610 and mpc8xx
Message-ID: <20080604001739.GB24548@polina.dev.rtsoft.ru>
References: <20080602173726.GA24556@polina.dev.rtsoft.ru>
	<20080603164830.32457962.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080603164830.32457962.akpm@linux-foundation.org>
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	wim@iguana.be, scottwood@freescale.com
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 03, 2008 at 04:48:30PM -0700, Andrew Morton wrote:
> On Mon, 2 Jun 2008 21:37:26 +0400
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > No comments on the previous version for two weeks... resending once
> > again.
> 
> I did all the rework to make the patches apply on top of all the
> pending watchdog work in Wim's tree and in -mm.  I haven't build tested
> it yet.

Thanks, I'll test it in run-time also.

> I'll assume that
> 
>  [PATCH 7/8] [POWERPC] fsl_soc: remove mpc83xx_wdt code
> 
> and
> 
>  [PATCH 8/8] [POWERPC] 86xx: mpc8610_hpcd: add watchdog node
> 
> are dependent upon the preceding six patches.  This might be wrong.

This is correct.

> Please put the subsystem identifier (eg, "watchdog" and "powerpc")
> outside the [], for reasons which should be in
> Documentation/SubmittingPatches, which used to be there but which got
> lost.  Bascially the text inside [] is for temporary not-for-committing
> information such as "rfc", "2.6.24-rc4", "resend", etc and should be stripped
> by the email recipient before merging.

Yeah, I know. It is just hard to remember all the preferences.

For example, PowerPC maintainers asking to do patches with "[POWERPC]"
identifier, this identifier purposely keeps intact for git-log.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
