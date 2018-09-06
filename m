Return-Path: <SRS0=IjWm=LU=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425lgK2bL0zF3Rr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2018 02:01:30 +1000 (AEST)
Date: Thu, 6 Sep 2018 12:01:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Pavel Machek <pavel@ucw.cz>, Henrik Austad <henrik@austad.us>,
 linux-doc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, "Paul E.
 McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett
 <josh@joshtriplett.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz
 <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Karsten Keil
 <isdn@linux-pingi.de>, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton
 <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Paul Moore
 <paul@paul-moore.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len
 Brown <len.brown@intel.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Greg Kroah-Hartman
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
Message-ID: <20180906120120.3dd1fc91@gandalf.local.home>
In-Reply-To: <20180906095804.5ab2716f@lwn.net>
References: <1536012923-16275-1-git-send-email-henrik@austad.us>
 <20180904113030.GB25177@amd>
 <20180904095908.13298b3d@gandalf.local.home>
 <20180906095804.5ab2716f@lwn.net>
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

On Thu, 6 Sep 2018 09:58:04 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Thanks,
> 
> jon  (who is increasingly inclined to apply this patch)

As Colin Kaepernick now says... "Just do it!"

;-)

-- Steve
