Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRvd02jD2zDqq4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 19:01:40 +1100 (AEDT)
Received: by mail-qt0-x242.google.com with SMTP id g14so17120346qti.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 00:01:40 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <4cc627c4-1aaf-b8d5-5a26-eea7e596743f@gmail.com>
References: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
 <20180121143117.19805-2-wsa+renesas@sang-engineering.com>
 <4cc627c4-1aaf-b8d5-5a26-eea7e596743f@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Jan 2018 09:01:37 +0100
Message-ID: <CAMuHMdVuN5iRLqWuPH_UVR1zDJK-rPHZ6guU-ssPuoZ=UWTAFw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] of: introduce event tracepoints for dynamic
 device_node lifecyle
To: Frank Rowand <frowand.list@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Frank,

On Thu, Jan 25, 2018 at 7:48 AM, Frank Rowand <frowand.list@gmail.com> wrote:
>>  create mode 100644 include/trace/events/of.h
>
> mode looks incorrect.  Existing files in include/trace/events/ are -rw-rw----

Not in my git clone ;-) 644 should be fine.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
