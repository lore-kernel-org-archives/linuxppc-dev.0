Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53035DDF0B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 05:03:54 +1000 (EST)
Date: Mon, 14 Apr 2008 12:03:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] Driver for Freescale 8610 and 5121 DIU
Message-Id: <20080414120303.dfe2a207.akpm@linux-foundation.org>
In-Reply-To: <48037C55.7060105@freescale.com>
References: <12053582234100-git-send-email-yorksun@freescale.com>
	<12053582231281-git-send-email-yorksun@freescale.com>
	<47D8572C.8090501@gmail.com> <47FFDBFF.1030809@gmail.com>
	<20080411221817.0b1eb414.akpm@linux-foundation.org>
	<48035E93.6070300@freescale.com> <48035F98.1020404@gmail.com>
	<48036001.10905@freescale.com> <4803620C.6020905@gmail.com>
	<48036649.6000409@freescale.com> <4803690A.3080105@gmail.com>
	<48036F00.6080200@freescale.com> <48037BA4.6070201@gmail.com>
	<48037C55.7060105@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, jirislaby@gmail.com, linux-kernel@vger.kernel.org,
	yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 14 Apr 2008 10:46:29 -0500
Timur Tabi <timur@freescale.com> wrote:

> Jiri Slaby wrote:
> 
> > Mainly because you can sleep inside locked mutex and because spinlock shouldn't
> > be used for too many lines of code (busy waiting etc.). I think ldd3 will be
> > more descriptive than me here :).
> 
> Ok, I'll look into it.
> 
> Andrew, do you want us to respin the patch, or would you be willing to let us
> make the change in a follow-up patch?

A fix against rc8-mm3 would be ideal for me.  But a replacement patch is OK
too - I'd convert that into an incremental so I can see what changed anyway.

Others might find the replacement patch harder to review though...
