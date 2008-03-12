Return-Path: <linuxppc-embedded@ml.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13891DE1BB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 08:15:08 +1100 (EST)
Date: Wed, 12 Mar 2008 22:15:04 +0100
From: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Using the loop feature of the DMA controller on MPC8544 DS
Message-ID: <20080312211504.GC11426@Chamillionaire.breakpoint.cc>
References: <20080312123437.GA1589@Chamillionaire.breakpoint.cc>
	<47D7FD9D.2040202@freescale.com>
	<20080312172024.GB7255@Chamillionaire.breakpoint.cc>
	<47D82542.8020000@freescale.com>
	<20080312204451.GA11426@Chamillionaire.breakpoint.cc>
	<47D841EE.2060806@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <47D841EE.2060806@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

* Timur Tabi | 2008-03-12 15:49:50 [-0500]:

>Well, I need to solve this problem myself, but I wasn't planning on doing it for
>a while since I have a higher priority assignment at the moment.  My 8610 sound
>driver does DMA all on its own and completely ignores Zhang's driver, so I need
>to fix that.
Ah okey. So you grab one DMA channel for yourself and you hope no one else
is going to use it? 
Are you using lists descriptors or single transfers?

>Unfortunately, I'm not familiar with Zhang's driver at all (it's changed too
>much since I last looked at it), so I don't know what the *best* way is. 
His driver uses DMA engine so you can't use the cool features / arch
specific settings.

>For my
>sound driver, I don't even know if I'll be able to leverage Zhang's driver at
>all, since I need to use a specific DMA channel, and I need to control each of
>the link descriptors.  Zhang's driver abstracts DMA too much.  So all I was
>going to do is come up with a way to reserve channels.
Welcome in my world :)

>Timur Tabi
>Linux kernel developer at Freescale

Sebastian
