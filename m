Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <002a01c44fc9$201dc820$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <20040611140919.84651C109F@atlas.denx.de> <40C9BED6.3010809@intracom.gr> <1086964452.15845.1308.camel@hades.cambridge.redhat.com>
Subject: Re: U-Boot and kernel 2.6
Date: Fri, 11 Jun 2004 11:31:04 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > Yeah, having the bi_recs interface actually working
> > would be ideal, but at the present time nothing is
> > working and as AFAIK no-one is working on it.
>
> So we should offer some gentle encouragement. Like refusing to accept
> any further modifications to include/asm-ppc/ppcboot.h.
>

Here's another idea - how about XML?  That would be two steps forward, IMO,
instead of just going from one magic structure to another.

As to just trashing bd_t, does that mean users have to upgrade their
bootloader to use newer kernels, and could not switch back easily if
problems arose?  Perhaps the kernel could identify whether the pointer is to
a bd_t or something else and handle it automatically?

Mark Chambers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
