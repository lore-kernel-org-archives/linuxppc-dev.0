Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "'Anton Blanchard'" <anton@samba.org>,
	"'Peter Bergner'" <bergner@vnet.ibm.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: TASK_UNMAPPED_BASE
Date: Fri, 6 Feb 2004 11:53:32 +0100
Message-ID: <000901c3ec9f$76acd7e0$0a01a8c0@LUMENTIS02>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <20040205170657.GA19011@krispykreme>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > The problem with a TASK_UNMAPPED_BASE that was "too low"
> > was referring to the bug where we always loaded ld.so at
> > TASK_UNMAPPED_BASE even though that adress was in the middle of the
> > bss. Now that has been fixed, "too low" isn't a concern anymore.
> >
> > However, I'm not sure moving the TASK_UNMAPPED_BASE below the text
> > section will work. It's used for more than just loading shared libs.
> > Anonymous mmap areas and the heap are all located relative to it.
>
> That reminded me of a patch wli did to rearrange how things are
> allocated. I wonder if doing something radical like this will work on
> ppc32.
[SNIP patch]

Hi Anton

I tried your patch on my 2.4 kernel.
uClibc boots fine with the libs loaded towards lower addresses.

glibc won't boot, hangs direcly after mount.

 Jocke

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
