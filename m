Message-ID: <3AC1032D.5396E3E3@mvista.com>
Date: Tue, 27 Mar 2001 13:16:29 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Zehetbauer Thomas <TZ@link.topcall.co.at>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: booting HardHat on IBM 405GP
References: <41EA756DBC9FD0118CFC0020AFDB5C5A188D96@tcint1ntsrv>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Zehetbauer Thomas wrote:
>
> It seems that execution stops when calling rfi in
> arch/ppc/kernel/head_4xx.S. I have put the sample code provided to
> output a single character on the serial port immediately before the rfi
> call and after the after the start_here label. Only the first is beeing
> executed. Any ideas?
>
> Tom

What kernel version are you using?  Where did you get the kernel?
What is the console output, from power on to the point where it hangs?


> > Zehetbauer Thomas wrote:
> > >
> > > My company is going to develop an embedded solution based
> > on a IBM 406GP
> > > processor.
> > > We are in early development right now and I am trying to
> > boot linux on a
> > > > IBM 25 EB 405 P4 WIN WAL 00
> > > evaluation kit (this is the information on the bill of delivery).
> > >
> > > Attempting to debug I've found
> > linux/arch/ppc/boot/tree/main.c:start to
> > > be the first function executed.
> > > At the very last step this function calls
> > > >    (*(void (*)())sa)(&board_info,
> > > >                      initrd_start,
> > > >                      initrd_start + initrd_size,
> > > >                      cmdline,
> > > >                      cmdline + strlen(cmdline));
> > > and I can't find where execution goes on.
> > >
> > > PS: Does someone know how to determine the board's revision number?

Check the PVR reported by the bootrom when you power on or reset the Walnut.

405GP rev B    PVR: 40110040
405GP rev C    PVR: 40110082
405GP rev D    PVR: 401100c4


>


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
