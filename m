Message-Id: <200009150254.DAA20954@hyperion.valhalla.net>
Date: Fri, 15 Sep 2000 03:55:06 +0100
Subject: Re: ld bug?
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> c039c3e0 D int_control
>
> as opposed to c03ac3e0 used in vmlinux.  So, it appears that ld or

This looks about the same as the difference reported by ksymoops (when it
refuses to work - reporting a mismatch between System.map and /proc/ksyms).

but I was seeing that on 2.2.17 (however, using the toolchain upgrades
recommended for 2.4.0).

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
