Message-ID: <0d5001c3eb09$0d02dbb0$3cc8a8c0@epro.dom>
From: "Colin Leroy" <colin@colino.net>
To: "Olaf Hering" <olh@suse.de>, <linuxppc-dev@lists.linuxppc.org>
References: <20040204101249.GA25776@suse.de>
Subject: Re: Video For Linux on ppc32 in kernel 2.6
Date: Wed, 4 Feb 2004 11:24:19 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> CONFIG_VIDEO_DEV triggers CONFIG_VIDEO_BUF. If compiled as module,
> video-buf.c wants clear_user_page(). This is a define on most archs
> (maps to clear_page()), on ppc32 it is an unexported function. This
> leads to unresolved symbols.


It's been fixed in BenH's tree since a few weeks.
(
http://ppc.bkbits.net:8080/linuxppc-2.5-benh/diffs/arch/ppc/kernel/ppc_ksyms.c@1.72 )
--
Colin
Ne disez pas disez, mais disez dites


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
