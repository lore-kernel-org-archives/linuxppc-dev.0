Message-Id: <20010827062142.Postino-014504@smtp01.highway.ne.jp>
Date: Mon, 27 Aug 2001 06:21:42 +0900
To: mlan@cpu.lu
Cc: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: Call for help: altivec-enabled vlc
In-Reply-To: <200108261754.TAA02887@piglet.grunz.lu>
References: <20010827013941.Postino-000926@smtp01.highway.ne.jp>
 <200108261754.TAA02887@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Michel Lanners <mlan@cpu.lu>
To: k_fukui@highway.ne.jp
Subject: Re: Call for help: altivec-enabled vlc
Date: Sun, 26 Aug 2001 19:54:13 +0200 (CEST)
cc: linuxppc-dev@lists.linuxppc.org

> On  27 Aug, this message from Kaoru Fukui echoed through cyberspace:
> >> I've sat down a bit ;-) and came up with an Altivec-optimised IDCT
> >
> > I don't know much.
> > Altivec-gcc need "-fvec" as gcc option.
>
> It's not altivec-enabled gcc; just plain asm which the assembler knows
> about (if you pass the right option which I'm doing ;-).
>

But gcc/config/rs6000.h doesn't have vector registor name.
if it's used gas,isn't it inline asm?

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
