Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C7A6CDDEED
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 14:15:46 +1000 (EST)
Date: Tue, 3 Jun 2008 21:15:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/8 v4] mpc83xx_wdt rework, support for mpc8610 and mpc8xx
Message-Id: <20080603211530.d6b3755a.akpm@linux-foundation.org>
In-Reply-To: <18502.5368.786188.835122@cargo.ozlabs.ibm.com>
References: <20080602173726.GA24556@polina.dev.rtsoft.ru>
	<20080603164830.32457962.akpm@linux-foundation.org>
	<20080604001739.GB24548@polina.dev.rtsoft.ru>
	<20080603173214.0bf71571.akpm@linux-foundation.org>
	<18502.5368.786188.835122@cargo.ozlabs.ibm.com>
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

On Wed, 4 Jun 2008 14:07:20 +1000 Paul Mackerras <paulus@samba.org> wrote:

> Looking at Linus' git tree, it's evident that some subsystems use the
> the "[SUBSYSTEM]" notation and some use "subsystem:".  If there is now
> an edict from on high that only "subsystem:" is acceptable, then I
> must have missed that memo.

I'm all edicted out.  Sometimes one just puts forth the reasoning and
lets others decide whether it's worth bothering about.  I could understand
that decision being "no" :)
