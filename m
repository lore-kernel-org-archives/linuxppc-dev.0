Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <c5254081722274cb11fd7d2bc4f3a91b95f0f9f6.1433959045.git.geoff@infradead.org>
References: <cover.1433959045.git.geoff@infradead.org>
 <c5254081722274cb11fd7d2bc4f3a91b95f0f9f6.1433959045.git.geoff@infradead.org>
Date: Thu, 11 Jun 2015 15:04:27 +0200
Message-ID: <CAMuHMdU=e=6UwQmZ0LJJhjf5DjG+Q7WsTBpm44uxeqGRqygs-Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] block/ps3vram: Remove obsolete reference to MTD
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Geoff Levand <geoff@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jim Paris <jim@jtan.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "cbe-oss-dev@lists.ozlabs.org" <cbe-oss-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 10, 2015 at 8:00 PM, Geert Uytterhoeven
<geert@linux-m68k.org> did not write:
> The ps3vram driver is a plain block device driver since commit
> f507cd22035fdadd5dbb476dd05e9e7ee21c3b84 ("ps3/block: Replace mtd/ps3vram
> by block/ps3vram").
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Geoff Levand <geoff@infradead.org>

For the record: while I did send out this patch back in 2013, I didn't resend it
yesterday.

Geoff:
  1. Please fix your scripts (start using git-send-email?), to avoid sending
     fake email. Thanks!
  2. I am grateful you didn't forget about this patch, and that it got applied.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
