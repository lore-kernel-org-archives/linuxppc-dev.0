Message-Id: <20000828173712.A2056@sirizidl.dialin.rrze.uni-erlangen.de>
Date: Mon, 28 Aug 2000 17:37:12 +0200
From: Richard Zidlicky <Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Iain Sandoe <iain@sandoe.co.uk>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux/PPC on APUS <linux-apus-devel@lists.sourceforge.net>
Subject: Re: [RFC] DMAsound 2.4.0-tx => 2.2.17 back-port.
References: <200008070101.CAA05135@hyperion.valhalla.net> <Pine.LNX.4.10.10008081558060.442-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10008081558060.442-100000@cassiopeia.home>; from Geert Uytterhoeven on Thu, Aug 24, 2000 at 03:07:59PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 24, 2000 at 03:07:59PM +0200, Geert Uytterhoeven wrote:

>   - Is it OK to use `AFMT_S16_LE' as startup mode for /dev/dsp? WAV-files can
>     be 8-bit as well, and always have a header so you can't just cat them to
>     /dev/dsp without static in the beginning anyway.

I think it is not a good idea for machines that don't even support
16 bit sampling, Q40 and some Atari versions come to mind.

Bye
Richard


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
