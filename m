Date: Thu, 24 Apr 2003 15:15:31 -0400
From: Kent Borg <kentborg@borg.org>
To: "Kerl, John" <John.Kerl@Avnet.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: boot/simple in ROM?
Message-ID: <20030424151531.K8490@borg.org>
References: <B895EFF5AF34724880036BDB5B5B81481355C0@amer22.avnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B895EFF5AF34724880036BDB5B5B81481355C0@amer22.avnet.com>; from John.Kerl@Avnet.com on Thu, Apr 24, 2003 at 11:06:32AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 24, 2003 at 11:06:32AM -0700, Kerl, John wrote:
> I based mine off boot/simple.  It runs fine from ROM.
>
> Suppose for example I have 32MB SDRAM from 0x00000000
> to 0x01ffffff, and 16MB flash from 0xff000000 to 0xffffffff.
> The key is that arch/ppc/boot/ld.script, and

...suddenly I GET it!  I was being too clever and trying to link for
my ROM address, and of course that will put the stack and bss in ROM.
Duh.

When I simply burn my 0x800000 RAM image at 0xfec00000 the bss and
stack are still down in 0x800000-range, and it works great.


Thanks to all for having such patience,

-kb, the Kent who is glad he didn't ask such a question on, say, the
qmail list.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
