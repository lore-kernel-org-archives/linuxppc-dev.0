Return-Path: <nicolas.dichtel@6wind.com>
Received: from mail-lf0-x22c.google.com (mail-lf0-x22c.google.com
 [IPv6:2a00:1450:4010:c07::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0S6J0tlXzDqHh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 03:01:11 +1100 (AEDT)
Received: by mail-lf0-x22c.google.com with SMTP id m78so41043049lfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 08:01:11 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v3 1/8] arm: put types.h in uapi
References: <1484304406-10820-2-git-send-email-nicolas.dichtel@6wind.com>
 <3131144.4Ej3KFWRbz@wuerfel>
 <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <25063.1484321803@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: arnd@arndb.de, linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
 alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
 linux-mtd@lists.infradead.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-am33-list@redhat.com, linux-c6x-dev@linux-c6x.org,
 linux-rdma@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-sh@vger.kernel.org, linux@armlinux.org.uk, coreteam@netfilter.org,
 fcoe-devel@open-fcoe.org, xen-devel@lists.xenproject.org,
 linux-snps-arc@lists.infradead.org, linux-media@vger.kernel.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 linux-kbuild@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net,
 linux-raid@vger.kernel.org, openrisc@lists.librecores.org,
 linux-fbdev@vger.kernel.org, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, netfilter-devel@vger.kernel.org,
 linux-alpha@vger.kernel.org, nio2-dev@lists.rocketboards.org,
 linuxppc-dev@lists.ozlabs.org
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <4633e475-47f2-5627-81a9-a1747dfddbc0@6wind.com>
Date: Fri, 13 Jan 2017 17:01:01 +0100
MIME-Version: 1.0
In-Reply-To: <25063.1484321803@warthog.procyon.org.uk>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Please, do not remove the email subject when you reply. I restore it to ease the
thread follow-up.

Le 13/01/2017 à 16:36, David Howells a écrit :
> Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
> 
>> This header file is exported, thus move it to uapi.
> 
> Exported how?
It is listed in include/uapi/asm-generic/Kbuild.asm, which is included by
arch/arm/include/uapi/asm/Kbuild.

You can also have a look at patch #5 to see why it was exported even if it was
not in an uapi directory.

Regards,
Nicolas
