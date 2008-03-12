Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5DBEEDDE05
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 08:17:36 +1100 (EST)
Message-ID: <47D8484B.10300@freescale.com>
Date: Wed, 12 Mar 2008 16:16:59 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
Subject: Re: Using the loop feature of the DMA controller on MPC8544 DS
References: <20080312123437.GA1589@Chamillionaire.breakpoint.cc>
	<47D7FD9D.2040202@freescale.com>
	<20080312172024.GB7255@Chamillionaire.breakpoint.cc>
	<47D82542.8020000@freescale.com>
	<20080312204451.GA11426@Chamillionaire.breakpoint.cc>
	<47D841EE.2060806@freescale.com>
	<20080312211504.GC11426@Chamillionaire.breakpoint.cc>
In-Reply-To: <20080312211504.GC11426@Chamillionaire.breakpoint.cc>
Content-Type: text/plain; charset=ISO-8859-1
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

Sebastian Siewior wrote:

> Ah okey. So you grab one DMA channel for yourself and you hope no one else
> is going to use it? 

Yes.  My driver was written first, that's how I was able to get away with it. :-)

> Are you using lists descriptors or single transfers?

Link descriptors.

-- 
Timur Tabi
Linux kernel developer at Freescale
