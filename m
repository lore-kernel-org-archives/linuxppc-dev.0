Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3twGsV0YV7zDqWd
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jan 2017 07:50:38 +1100 (AEDT)
Received: by mail-qk0-x243.google.com with SMTP id a20so11244147qkc.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Jan 2017 12:50:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483695839-18660-5-git-send-email-nicolas.dichtel@6wind.com>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <1483695839-18660-5-git-send-email-nicolas.dichtel@6wind.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 6 Jan 2017 22:50:34 +0200
Message-ID: <CAHp75VdDfopdSy-7oy87ZeosDB9+FN4zFBhErPWLQB7tH81zTw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] x86: put msr-index.h in uapi
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Arnd Bergmann <arnd@arndb.de>, mmarek@suse.com,
 linux-kbuild@vger.kernel.org,
 Linux Documentation List <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org,
 Cris <linux-cris-kernel@axis.com>, uclinux-h8-devel@lists.sourceforge.jp,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, linux-am33-list@redhat.com,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org,
 Linux-SH <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, Linux-Arch <linux-arch@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, netdev <netdev@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, linux-nfs@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-spi <linux-spi@vger.kernel.org>,
 "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
 linux-rdma@vger.kernel.org, fcoe-devel@open-fcoe.org,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 linux-fbdev@vger.kernel.org,
 xen-devel@lists.xenproject.org, David Airlie <airlied@linux.ie>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 6, 2017 at 11:43 AM, Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
> This header file is exported, thus move it to uapi.

Just hint for the future:
-M (move)
-C (copy)
-D (delete) [though this is NOT for applying]

-- 
With Best Regards,
Andy Shevchenko
