Return-Path: <SRS0+6fcec71e9a37e012d0a0+1702+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D60CDE15C
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 18:03:13 +1000 (EST)
Subject: Re: removal of arch/ppc in 2.6.27?
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18443.13999.770734.826892@cargo.ozlabs.ibm.com>
References: <D713F373-AE2A-4341-9C29-EF65B9399B36@kernel.crashing.org>
	<200804201314.47311.marvin24@gmx.de>
	<18443.13999.770734.826892@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 21 Apr 2008 09:03:05 +0100
Message-Id: <1208764985.9212.453.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-04-20 at 22:27 +1000, Paul Mackerras wrote:
> Marvin writes:
> 
> > will this be the end of life for all the PReP's ? I remember a patch posted 
> > some month ago, but didn't heard anything since then. Any news? Or just let 
> > it die quietly?
> 
> No, I'm still planning on getting PReP support over to arch/powerpc,
> but getting time to work on it has been the difficulty.
> 
> What sort of PReP do you have?

I have a 43P-140, which I bought on eBay a few weeks ago to add to the
Fedora testing pile. Foolishly I was trying to get the CHRP kernel
booting on it, just because it says 'chrp' in its device_type.

Unfortunately I seem to have killed it -- I tried to update its firmware
from TIG97251 to TIG04204 and although the update looked successful, it
never came back. Says 'F2A' on the diagnostic panel. I renamed the
firmware file on the floppy to 'precover.img' as the documentation
suggests, but it never even looks at the floppy drive when it starts up.

Anyone know if the firmware flash on these can be removed and flashed
externally, or have any better suggestions?

-- 
dwmw2
