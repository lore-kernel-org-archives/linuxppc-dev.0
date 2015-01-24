Return-Path: <semen.protsenko@globallogic.com>
Received: from exprod5og108.obsmtp.com (exprod5og108.obsmtp.com [64.18.0.186])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A59A1A0DC9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jan 2015 07:54:33 +1100 (AEDT)
Received: by mail-la0-f53.google.com with SMTP id gq15so2615983lab.12
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jan 2015 12:54:29 -0800 (PST)
MIME-Version: 1.0
Reply-To: semen.protsenko@globallogic.com
In-Reply-To: <1422118156.27947.7.camel@x220>
References: <1422117213-3130-1-git-send-email-semen.protsenko@globallogic.com>
 <1422118156.27947.7.camel@x220>
Date: Sat, 24 Jan 2015 22:54:28 +0200
Message-ID: <CAJOTznWHpRh8ysVxwSWyvZL1UAe-G9A64j=M6z0+zPeoycgkDg@mail.gmail.com>
Subject: Re: [PATCH 0/4] defconfigs: cleanup obsolete MTD configs
From: Sam Protsenko <semen.protsenko@globallogic.com>
To: Paul Bolle <pebolle@tiscali.nl>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mips@linux-mips.org, Brian Norris <computersforpeace@gmail.com>,
 Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linux-mtd@lists.infradead.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Haavard Skinnemoen <hskinnemoen@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> That's news for me. I thought they are silently ignored. Do you have an
> example of such a warning?

Not really. It was just assumption. It seems you are right, they are just
ignored silently. But item 2 is still relevant and it was actually confused
me when I tried to figure out MTD configuration for my platform.
Anyway, garbage should be taken out from time to time.

> Seems like the kind of change that can only be reviewed by a script.

Good point. Because these patches were done by script to start with.
Anyway, I reviewed result patches manually to be completely sure.
You can write verifying script though, if you need to, it wouldn't take
more than 2 minutes (it takes one-liner, actually).

> I seem to remember Greg stating that defconfig files are on their way
> out. Did I remember that correctly?

Maybe they are. But they still in place, and why it's so, we should
maintain them up-to-date. Ideally, this kind of work should be done by
someone who introduces changes into Kconfig files. So I just fixed
that oversight.
