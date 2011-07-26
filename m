Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 76C06B6F7B
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jul 2011 06:10:30 +1000 (EST)
Date: Tue, 26 Jul 2011 15:10:24 -0500
From: Scott Wood <scottwood@freescale.com>
To: <MichaelHench@gmail.com>
Subject: Re: [PATCH v3] mtd: eLBC NAND: update ecc_stats.corrected when
	lteccr available
Message-ID: <20110726151024.706ccda0@schlenkerla.am.freescale.net>
In-Reply-To: <CAHyXW61rWcoE0Wcd9K7BsP3+VKzmQo=RPMM9+1DTw+QdF9MVew@mail.gmail.com>
References: <CAHyXW61rWcoE0Wcd9K7BsP3+VKzmQo=RPMM9+1DTw+QdF9MVew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org, mlcreech@gmail.com,
	mhench@elutions.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 26 Jul 2011 15:07:42 -0500
Michael Hench <michaelhench@gmail.com> wrote:

> update ecc_stats.corrected if LTECCR register is available.
> 
> v2: kernel standard C formatting
> 
> v3: kernel standard C formatting again, changed a comment to get under 80 chars
> 
> Signed-off-by: Michael Hench <MichaelHench@gmail.com>

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
