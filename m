Message-ID: <3959F2E3.5361A5D9@wibble.net>
Date: Wed, 28 Jun 2000 22:43:15 +1000
From: Steven Hanley <sjh@wibble.net>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: problem with compressing the kernel
References: <Pine.HPX.4.10.10006281352560.5670-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Not in the compilation, but since when do you use
> cvs/rsync/bitkeeper/whatever ?

cvs since Tridge showed it to me a few years ago and how to use it well,
thus I used to get kernel source from samba.anu.edu.au's cvs tree often
(depending on what was using said source for), as for rsync, since I
started using ppc as Paul keeps his kernels on linuxcare.com.au
available over rsync. Anyway I was just using them as current examples
where gzip and bzip2 are not required, just as you used the fact
generally kernel's are obtained in tar.{gz,bz2} format as an argument
for needing the appropriate tool. I still would say the Changes file is
not out of date or anythng (as you previously suggested) as there is no
requirement for gzip or bzip2 to build the kernel from source, this is
what the file claims to cover. However this is just being picky.

> The official source tree (the mirrors of ftp.kernel.org) is still only
> available as gz and more recently with bz2. So historically gzip has been
> a prerequisite to look at the kernel source and build your kernel, that's
> all what I claimed (did you use Linux and build your kernels from
> ftp.funet.fi in 1995 ?).

well until recently I only had x86 boxes, but admittedly the argument is
academic as you wont find a linux box on which you compile kernels (ie
not some small embedded system, etc etc) without gzip installed.


--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
