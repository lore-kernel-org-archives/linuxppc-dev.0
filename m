Message-ID: <396DFF7E.5741A903@mvista.com>
Date: Thu, 13 Jul 2000 12:42:22 -0500
From: Jim Lewis <jlewis@mvista.com>
MIME-Version: 1.0
To: Steven Tarr <tarr@lucent.com>
CC: "Dan A. Dickey" <ddickey@charter.net>, Kwansuk Kim <kskim@neowave.co.kr>,
        LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: network toolsl don't still work...
References: <NEBBKFENMLEDKDHMEHPJKEPECAAA.kskim@neowave.co.kr> <396D3C79.2332C112@charter.net> <396DD286.EF20C9F5@lucent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven,
If you strip libnss_files.so-2.1.3, it is about 40K. That is still more than 10 lines of
code, but it is lots better than 240K!

-Jim
Steven Tarr wrote:

> Mr. Dickey ---
>
> Please have an ice cream cone on me!  I thank you.
>
> cheers --
> tarr
>
> NOTE  - libnss_files.so-2.1.3 and its various links need to be included in the
> libraries....
>
> NOTE2 -  So, I have to add a library of >240K   so that I can get a simple network
> (ping)
>                        application to function! The original function
> getprotobyname() was 10 lines of C code.
>
> "Dan A. Dickey" wrote:
>
> > Kwansuk Kim wrote:
> > >
> > > Thanks for you cooperation.
> > >
> > > When I make soft link from /lib to /opt/.../lib, bash can read the library files.
> > >
> > > But ping program doesn't work yet.
> >
> > Check /etc/nsswitch.conf
> >         -Dan
> >
>
> --
> Steve Tarr
> tarr@lucent.com
> 303-538-4056
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
