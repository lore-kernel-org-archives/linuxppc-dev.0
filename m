Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 12BC3DE0D0
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 09:48:46 +1000 (EST)
Date: Tue, 3 Jun 2008 16:48:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 0/8 v4] mpc83xx_wdt rework, support for mpc8610 and mpc8xx
Message-Id: <20080603164830.32457962.akpm@linux-foundation.org>
In-Reply-To: <20080602173726.GA24556@polina.dev.rtsoft.ru>
References: <20080602173726.GA24556@polina.dev.rtsoft.ru>
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

On Mon, 2 Jun 2008 21:37:26 +0400
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> No comments on the previous version for two weeks... resending once
> again.

I did all the rework to make the patches apply on top of all the
pending watchdog work in Wim's tree and in -mm.  I haven't build tested
it yet.


I'll assume that

 [PATCH 7/8] [POWERPC] fsl_soc: remove mpc83xx_wdt code

and

 [PATCH 8/8] [POWERPC] 86xx: mpc8610_hpcd: add watchdog node

are dependent upon the preceding six patches.  This might be wrong.


Please put the subsystem identifier (eg, "watchdog" and "powerpc")
outside the [], for reasons which should be in
Documentation/SubmittingPatches, which used to be there but which got
lost.  Bascially the text inside [] is for temporary not-for-committing
information such as "rfc", "2.6.24-rc4", "resend", etc and should be stripped
by the email recipient before merging.
