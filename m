To: "machael thailer" <dony.he@huawei.com>
Cc: "Michael Habermann" <MHabermann@gmx.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Uncompress Ok, but cannot run linux kernel... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 08 May 2001 16:06:19 +0800."
             <000b01c0d795$c3e15f80$8021690a@huawei.com>
Date: Tue, 08 May 2001 10:43:51 +0200
Message-Id: <20010508084356.615D42814D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000b01c0d795$c3e15f80$8021690a@huawei.com> you wrote:
>
> > The kernel is loaded with ppcboot and the tftpboot commando. To trace, I
> > used mpc8bug.
...
> > I set a breakpoint at the entry of the __start routine. After passing
> > the turn_on_mmu label, it returns with an rfi and hangs.
>
> This is exactly what I meet now.
> If you have good solutions, please let me know.

Use a debugger that understands the MMU, like the BDI2000 by Abatron.

In any case, make sure the DER does not trap into BDM mode on  normal
MMU work, i. e. set it to something like 0x2002000F.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"I didn't know it was impossible when I did it."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
