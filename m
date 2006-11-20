Return-Path: <jsimmons@infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8D9867BFE
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 03:52:00 +1100 (EST)
Date: Mon, 20 Nov 2006 16:51:39 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
In-Reply-To: <20061118000235.GV31879@stusta.de>
Message-ID: <Pine.LNX.4.64.0611201648550.17639@pentafluge.infradead.org>
References: <20061118000235.GV31879@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sammy@sammy.net, linux-fbdev-devel@lists.sourceforge.net,
	sun3-list@redhat.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-m68k@lists.linux-m68k.org,
	geert@linux-m68k.org, adaplas@pol.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This patch removes video drivers that:
> - had already been marked as BROKEN in 2.6.0 three years ago and
> - are still marked as BROKEN.
> 
> These are the following drivers:
> - FB_CYBER
> - FB_VIRGE
> - FB_RETINAZ3
> - FB_ATARI
> - FB_SUN3
> - FB_PM3

If someone is willing to send me a Permedia3 card I can port the driver. 
The rest are m68k drivers. I do have S3Trio and a Virge card but no specs.
