To: Peter Barada <pbarada@mail.wm.sps.mot.com>
Cc: Peter.Barada@motorola.com, kentborg@borg.org,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdbserver, find_extend_vma(), and VM_GROWSDOWN 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 07 Jul 2003 13:05:22 EDT."
             <200307071705.h67H5MD01399@hyper.wm.sps.mot.com>
Date: Mon, 07 Jul 2003 19:20:18 +0200
Message-Id: <20030707172023.DB957C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200307071705.h67H5MD01399@hyper.wm.sps.mot.com> you wrote:
>
> >Did you try GDB/gdbserver from the ELDK?
>
> No.

Try it, then.

> Where did the gdbserver in ELDK come from and how is it different from
> gdbserver from gdb-5.3?

It's based on GDB-5.1, and we fixed a couple of problems.



Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"In matters of principle, stand like a rock;  in  matters  of  taste,
swim with the current."                            - Thomas Jefferson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
