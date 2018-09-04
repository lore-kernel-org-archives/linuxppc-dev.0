Return-Path: <axboe@kernel.dk>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
 [209.85.214.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424WRQ20R2zF13F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 01:46:54 +1000 (AEST)
Received: by mail-it0-f68.google.com with SMTP id h1-v6so5374695itj.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2018 08:46:54 -0700 (PDT)
Subject: Re: [PATCH] [RFC v2] Drop all 00-INDEX files from Documentation/
To: Henrik Austad <henrik@austad.us>, linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Karsten Keil <isdn@linux-pingi.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>,
 Paul Moore <paul@paul-moore.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller
 <deller@gmx.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jslaby@suse.com>, Mark Brown <broonie@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Evgeniy Polyakov <zbr@ioremap.net>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Ian Kent <raven@themaw.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Jan Kandziora <jjj@gmx.de>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-ide@vger.kernel.org, netdev@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-mips@linux-mips.org,
 linux-security-module@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-spi@vger.kernel.org, kvm@vger.kernel.org,
 Henrik Austad <haustad@cisco.com>
References: <1536012923-16275-1-git-send-email-henrik@austad.us>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cab5289c-7c53-28a8-b9b2-0c55c9f8d968@kernel.dk>
Date: Tue, 4 Sep 2018 09:45:47 -0600
MIME-Version: 1.0
In-Reply-To: <1536012923-16275-1-git-send-email-henrik@austad.us>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/3/18 4:15 PM, Henrik Austad wrote:
> This is a respin with a wider audience (all that get_maintainer returned)
> and I know this spams a *lot* of people. Not sure what would be the correct
> way, so my apologies for ruining your inbox.
> 
> The 00-INDEX files are supposed to give a summary of all files present
> in a directory, but these files are horribly out of date and their
> usefulness is brought into question. Often a simple "ls" would reveal
> the same information as the filenames are generally quite descriptive as
> a short introduction to what the file covers (it should not surprise
> anyone what Documentation/sched/sched-design-CFS.txt covers)
> 
> A few years back it was mentioned that these files were no longer really
> needed, and they have since then grown further out of date, so perhaps
> it is time to just throw them out.
> 
> A short status yields the following _outdated_ 00-INDEX files, first
> counter is files listed in 00-INDEX but missing in the directory, last
> is files present but not listed in 00-INDEX.

For the block related bits:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
