Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9738DDDEF
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 10:32:29 +1000 (EST)
Date: Tue, 3 Jun 2008 17:32:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 0/8 v4] mpc83xx_wdt rework, support for mpc8610 and mpc8xx
Message-Id: <20080603173214.0bf71571.akpm@linux-foundation.org>
In-Reply-To: <20080604001739.GB24548@polina.dev.rtsoft.ru>
References: <20080602173726.GA24556@polina.dev.rtsoft.ru>
	<20080603164830.32457962.akpm@linux-foundation.org>
	<20080604001739.GB24548@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 4 Jun 2008 04:17:39 +0400
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> > Please put the subsystem identifier (eg, "watchdog" and "powerpc")
> > outside the [], for reasons which should be in
> > Documentation/SubmittingPatches, which used to be there but which got
> > lost.  Bascially the text inside [] is for temporary not-for-committing
> > information such as "rfc", "2.6.24-rc4", "resend", etc and should be stripped
> > by the email recipient before merging.
> 
> Yeah, I know. It is just hard to remember all the preferences.
> 
> For example, PowerPC maintainers asking to do patches with "[POWERPC]"
> identifier, this identifier purposely keeps intact for git-log.

Addition of "[powerpc]" if it was absent can be scripted.

However, the retaining of "[powerpc]" (etc) while not retaining "[rfc]"
(etc) is not practical.

Plus putting things into git with "[powerpc]" in the title is wrong. 
The chances are good that anyone who is taking such a patch off the
git-commits list (say, for a backport) will lose that part of the
title.  It should be "powerpc: "

(http://userweb.kernel.org/~akpm/dh.gif)
