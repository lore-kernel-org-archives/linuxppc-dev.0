Return-Path: <SRS0+61c1008cfb9f6953af6c+1205+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4AA32679E0
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 22:20:22 +1100 (EST)
Date: Mon, 11 Dec 2006 11:20:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: linuxppc-dev@ozlabs.org, paulus@samba.org, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org
Subject: Re: powerpc: "IRQ probe failed (0x0)" on powerbook
Message-ID: <20061211112017.GA16399@infradead.org>
References: <87lklg9rkz.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87lklg9rkz.fsf@briny.internal.ondioline.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 10, 2006 at 07:45:48PM +1300, Paul Collins wrote:
> On my PowerBook when booting Linus's tree as of commit af1713e0 I get
> something like this:
> 
>   [blah blah]
>   ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 0
>   Probing IDE interface ide0...
>   hda: HTS541080G9AT00, ATA DISK drive
>   IRQ probe failed (0x0)
>   IRQ probe failed (0x0)
>   IRQ probe failed (0x0)
>   IRQ probe failed (0x0)
> 
> And then of course it fails to mount root.  No such problem using a
> kernel built from commit 97be852f of December 2nd.

Same here, btw - except that I couldn't catch the exact message as
nicely.
