Message-ID: <008601c1f61c$63162f40$6401a8c0@attbi.com>
Reply-To: "Greg Griffes" <ggg@ieee.org>
From: "Greg Griffes" <ggg@ieee.org>
To: "Jeffrey W. Daugherty" <jwdaugherty@lucent.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <Pine.LNX.4.44.0205071135570.29700-100000@localhost.localdomain>
Subject: Re: Linux w/o disk, network, or ROM
Date: Tue, 7 May 2002 19:10:31 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Does anyone have any suggestions?  What might be missing either
> in kernel configuration or platform_init()?  Help!
>

Jeffery,

What boot loader are you using?

If you are using the "simple" boot loader,
you may need a call to parse_bootinfo(find_bootinfo());
in platform_init().  That call will read the bi_record
struct built by the boot loader and initialize globals
such as initrd_start and initrd_size.

Greg


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
