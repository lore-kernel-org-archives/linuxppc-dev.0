Message-Id: <4.3.1.2.20000512142831.00c41100@mail.munich.netsurf.de>
Date: Fri, 12 May 2000 14:36:26 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: compile problem with current bk tree
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.GSO.4.10.10005120835040.2055-100000@dandelion.sonytel
 .be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 08:37 12.05.00, Geert Uytterhoeven wrote:
>| ccallisto$ gcc -v
>| Reading specs from /usr/lib/gcc-lib/powerpc-linux/egcs-2.91.66/specs
>| gcc version egcs-2.91.66 Debian GNU/Linux (egcs-1.1.2 release)
>| callisto$
>
>Any suggestions?

Use gcc-2.95.2 or later :-). egcs-1.1.2 is not recommended anymore for PPC.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
