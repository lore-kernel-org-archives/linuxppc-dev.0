Message-Id: <5.1.0.14.0.20011018123155.026b01c0@pop.gmx.de>
Date: Thu, 18 Oct 2001 12:39:36 +0800
To: Joe Green <jgreen@mvista.com>, Wolfgang Denk <wd@denx.de>
From: Michael Habermann <MHabermann@gmx.de>
Subject: Re: Reducing glibc with mklibs.sh
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <01101709304900.12705@minotaur.mvista.com>
References: <20011017123040.23ED310889@denx.denx.de>
 <20011017123040.23ED310889@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 09:28 AM 10/17/2001 -0700, Joe Green wrote:
> > The MV Library Optimizer at
> > http://sourceforge.net/projects/libraryopt/ it's under GPL.
>
>Yes, but it's not well documented yet...I need to improve that and add
>a mailing list.

libopt looks great, but I don't know how to handle it.
After setting the toolprefix manually, I call the software in this way:
         ./powerpc-linux-libopt -d /ppcroot.smalllib /ppcroot

/ppcroot/ contains my RAMDisk. The program executes up to the end of main
without error messages, but /ppcroot.smallib/ is empty after execution.

Is it possible, that the script runs only with HardHat Linux?
It seems that when DynamicLibrary.generate(...) is called, self.optimizer
is always None.
The optimizers are read from an optinfo file, which I don't have. Where to
get one?

I have also no idea, what libindex is good for.


> > /usr/local/powerpc-linux/bin/ld: /tmp/,mklibs.21079/lib-so: undefined
> > versioned symbol name sys_siglist@@GLIBC_2.1
>
>This looks like a problem with COPY relocation types, which was seen and
>fixed for the LOT.

Any hint how to fix it?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
