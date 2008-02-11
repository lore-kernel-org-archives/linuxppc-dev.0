Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C322DDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Feb 2008 20:37:15 +1100 (EST)
Date: Mon, 11 Feb 2008 12:37:03 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Subject: Re: Where is fcc_enet.c
Message-ID: <20080211123703.5e046897@kernel.crashing.org>
In-Reply-To: <F795765B112E7344AF36AA911279641502D1AA74@xmb-sjc-212.amer.cisco.com>
References: <F795765B112E7344AF36AA911279641502D1AA74@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun, 10 Feb 2008 15:08:46 -0800
Bizhan Gholikhamseh (bgholikh) wrote:

> Hi,
> I am porting to Linux 2.6.24 from linux 2.6.11 on mpc85xx cds
> platform, I am not able to locate fcc_enet.c file under
> linux 2.6.24 source tree, any idea????
try drivers/net/fs_enet

at least CPM2 FCC is handled in there.


-- 
Sincerely, Vitaly
