Message-Id: <20001227200444.Postino-005726@smtp01.highway.ne.jp>
Date: Wed, 27 Dec 2000 20:04:44 +0900
To: <linuxppc-dev@lists.linuxppc.org>
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: how to use macro in assemble language embedded in C?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Hi,
>
> (NOTE: when reply this mail, please cc: kerler@newmail.net , thanks)
>
> I change the first line of temp.c:
>     asm("#include <asm\\ptrace.h>\n\t");
> to
>     asm("#include <asm/ptrace.h>\n\t");
> ==========temp.c==================
>  asm("#include <asm/ptrace.h>\n\t");
>  void dummy (void)
>  {
>      asm("stwu   %r1, -PT_R16(%r1)");             /* stack */
>  }

The problem is in YOUR syntax.
Inline asm is C launguage ,so C rabel can not put in string field like "-PT
_R16".
The compiler doesn't search the rabel which is put in string field

You can find some examples in asm-ppc.

cd /usr/include/asm
grep -n asm * | more

The documentation is gcc source.
Plaese get some new gcc's source,then open that.
*importance*
Read gcc/extend.texi.

There is much help.

More help is there(in gcc source).
cd gcc
grep -n asm | more

You will have much help there.

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
