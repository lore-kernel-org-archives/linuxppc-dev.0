Date: Wed, 17 Jan 2001 16:41:39 -0600 (CST)
From: Grant Erickson <erick205@umn.edu>
To: Hua Ji <hji@netscreen.com>
cc: "'crossgcc@sources.redhat.com'" <crossgcc@sources.redhat.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hello World and 405GP with my gcc cross compiling.
In-Reply-To: <A33AEFDC2EC0D411851900D0B73EBEF7063E55@NAPA>
Message-Id: <Pine.SOL.4.20.0101171638350.8041-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 17 Jan 2001, Hua Ji wrote:
> My current position is:
>
> I have no problem for creating the object file, say, HelloWorld.o by
> using my gcc for powerpc-elf under a solaris.
>
> And then I moved the object file from solaris to a PC and used the IBM
> High c/C++ linker to link my Helloworld.o with the sample "usr_samp"
> codes provided by IBM 405GP reference kit. It works fine after being
> loaded with the tftp... In other words, it is running on my 405GP
> reference board and print out my inserted "hello world..."!

I never had much luck linking GCC generated objects with IBM's High C/C++
linker and libraries.

I think your effort would be better invested if you grabbed the Hard Hard
Linux kernel for the 405GP from MontaVista and set-up an associated NFS
root disk and attempted your development from there.

If you follow the instructions at:

	http://www.borg.umn.edu/~grant/Linux/cross.html

The applications you create will run with Monta Vista's kernel and NFS
root file system.

> So, my conclusion is: my gcc for powerpc-elf works, at least for
> creating object file part.
>
> Now, why I can't direct creat the executable file but get the above
> compain? Looks like it can't find correct libc codes, for example, the
> __start and printf symbol and so on.
>
> What my environment is: I used newlib to creat my libc.a. However, I
> am not sure if my native gcc use gnulic or newlib. does this matter?
>
> Any clue, folks,

--
 Grant Erickson                       University of Minnesota Alumni
  o mail:erick205@umn.edu                                 1996 BSEE
  o http://www.umn.edu/~erick205                          1998 MSEE


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
