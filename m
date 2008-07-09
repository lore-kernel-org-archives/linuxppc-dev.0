Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 0A1EDDDE23
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jul 2008 03:17:42 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so783207yxg.39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 09 Jul 2008 10:17:41 -0700 (PDT)
Date: Wed, 9 Jul 2008 11:17:38 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: mejjad lahcen <lmejjad@gmail.com>
Subject: Re: merge from arch/ppc to arch/powerpc on lite5200
Message-ID: <20080709171738.GD28130@secretlab.ca>
References: <9b4863980807090742n3c7f7f0bl91ebe85b8d1fe00c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9b4863980807090742n3c7f7f0bl91ebe85b8d1fe00c@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jul 09, 2008 at 10:42:09AM -0400, mejjad lahcen wrote:
>  Hi all of you,
> I am working to port linux2.6.26 on board based on lite5200, but the kernel
> hangs here ( see output)

This is not a ramdisk problem.  It looks like the kernel is starting but
the console is not setup correctly.  To help, I need more information:

- What command in u-boot are you using to boot the board
- How are you building your kernel image?
- Can you post the .dts file for your board?

> Memory <- <0x0 0x4000000> (64MB)
> CPU clock-frequency <- 0x1687d280 (378MHz)
> CPU timebase-frequency <- 0x1406f40 (21MHz)
> CPU bus-frequency <- 0x501bd00 (84MHz)

These look odd.  What frequencies does U-Boot report when it comes out
of reset?

Cheers,
g.
