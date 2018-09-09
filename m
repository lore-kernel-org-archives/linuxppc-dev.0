Return-Path: <corbet@lwn.net>
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427kR50ysYzF3MW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 07:12:48 +1000 (AEST)
Date: Sun, 9 Sep 2018 15:12:37 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Henrik Austad <henrik@austad.us>
Cc: linux-doc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, "Paul E.
 McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett
 <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Jens Axboe <axboe@kernel.dk>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej
 Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij
 <linus.walleij@linaro.org>, "David S. Miller" <davem@davemloft.net>,
 Karsten Keil <isdn@linux-pingi.de>, Masahiro Yamada
 <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will
 Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul
 Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Paul Moore
 <paul@paul-moore.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len
 Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin
 Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens
 <heiko.carstens@de.ibm.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Brown
 <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Evgeniy Polyakov <zbr@ioremap.net>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ian Kent
 <raven@themaw.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Mike
 Rapoport <rppt@linux.vnet.ibm.com>, Jan Kandziora <jjj@gmx.de>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-ide@vger.kernel.org, netdev@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-mips@linux-mips.org,
 linux-security-module@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-spi@vger.kernel.org, kvm@vger.kernel.org,
 Henrik Austad <haustad@cisco.com>
Subject: Re: [PATCH] [RFC v2] Drop all 00-INDEX files from Documentation/
Message-ID: <20180909151237.4bc1b3e2@lwn.net>
In-Reply-To: <1536012923-16275-1-git-send-email-henrik@austad.us>
References: <1536012923-16275-1-git-send-email-henrik@austad.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  4 Sep 2018 00:15:23 +0200
Henrik Austad <henrik@austad.us> wrote:

> I don't really have an opinion to whether or not we /should/ have 00-INDEX,
> but the above 00-INDEX should either be removed or be kept up to date. If
> we should keep the files, I can try to keep them updated, but I rather not
> if we just want to delete them anyway.
> 
> As a starting point, remove all index-files and references to 00-INDEX and
> see where the discussion is going.

Applied, thanks.

jon
