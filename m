Message-ID: <35C119252057D511BB9F0003476BF8A208E5D0@freexc01.smartm.com>
From: "Prasad, Siva" <Siva.Prasad@smartm.com>
To: "'Mark Hatle'" <fray@mvista.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Ramdisk: kernel panic...
Date: Tue, 2 Oct 2001 09:57:22 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am getting the same "Kernel panic" message still even after using
'ash.static' in place of '/bin/sh'. So, I guess this is not a library
problem. Then what is it?... and how to go about debugging this problem.

I just want to try out '/bin/sash' also. How to get that code which is in
professional version of HHL 2.0.

I am just calling
execve("/bin/sh", ...
and not any of the init's.
Found that 'do_execve' returns fine, after that kernel panics.

Using Linux_2_4_devel source as on Sep 26th. For PPC750 board. Using Force's
PowerBoot as boot loader. Using 'PowerCore' option for building.

Any suggestion would be greatly appreciated.

Thanks in advance.

-- Siva


> -----Original Message-----
> From: Mark Hatle [mailto:fray@mvista.com]
> Sent: Monday, October 01, 2001 7:06 PM
> To: Prasad, Siva
> Subject: Re: Ramdisk: kernel panic...
>
>
> "Prasad, Siva" wrote:
> >
> > Hi Mark,
> >
> > Thanks a lot for the help and time that you had extended.
> > As you suggested, I had installed HHL2.0 (for Sandpoint
> since it uses 7xx).
> >
> > In the directory /hardhat/devkit/ppc/7xx/target/bin, I
> don't see "sash". Can
> > you please point me to exact place where I can find this
> file and use that
> > in my ramdisk.
> >
> > "ash.static" is present in the directory. Can I copy that
> as "/bin/sh"???.
> > Do I have to copy any libraries too along with that???.
> >
> > Thanks for the patience.
> >
> > -- Siva
>
>
> You can copy ash.static as "/bin/sh".  There are no libraries required
> for it to work.
>
> I just realized that sash is not part of Journeyman, but our
> professional kit.  So ash.static will have to do.  If you can boot up
> and into ash.static then your system is working.. (more or less...)
>
> At that point you can be more adventerous and copy regular apps and
> their associated libraries and try that.
>
> --Mark
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
