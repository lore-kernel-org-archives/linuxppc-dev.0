Return-Path: <cbouatmailru@gmail.com>
Received: from mail-bw0-f218.google.com (mail-bw0-f218.google.com
	[209.85.218.218]) by ozlabs.org (Postfix) with ESMTP id 7A79AB7C09
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Apr 2010 00:23:07 +1100 (EST)
Received: by bwz10 with SMTP id 10so107313bwz.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Mar 2010 06:23:03 -0700 (PDT)
Date: Wed, 31 Mar 2010 17:23:00 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Christian Kujau <lists@nerdbynature.de>
Subject: Re: kexec for powerpc32
Message-ID: <20100331132300.GA15951@oksana.dev.rtsoft.ru>
References: <alpine.DEB.2.01.1003310430570.5493@bogon.housecafe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.DEB.2.01.1003310430570.5493@bogon.housecafe.de>
Cc: Maxim Uvarov <muvarov@ru.mvista.com>, horms@verge.net.au,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, Mar 31, 2010 at 05:18:18AM -0700, Christian Kujau wrote:
> [please CC me as I am not subscribed]
> 
> Hi,
> 
> when building a kernel for powerpc32 (PowerBook6,8 / 7447A) I can select
> CONFIG_KEXEC. However, after booting I can't convince kexec (from 
> kexec-tools, latest git checkout) to load the kernel:
> 
> # /opt/kexec-tools/sbin/kexec -l /boot/2.6/zImage --append="root=/dev/hda6" 
> get_memory_ranges(): Unsupported platform
> Could not get memory layout

Kernel has all needed for kexec, but kexec-tools are broken for
powerpc32.

http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg22498.html

I've just asked around, and it seems that Maxim (Cc'ed) will start
working on reviving ppc32 support real soon.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
