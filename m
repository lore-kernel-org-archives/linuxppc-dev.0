Date: Thu, 4 May 2000 10:06:25 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: john peter grimes <jpgrimes@rainbow.uchicago.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: KDE 2.0 compilation problems
In-Reply-To: <Pine.SGI.3.96.1000503191045.17758D-100000@rainbow.uchicago.edu>
Message-ID: <Pine.LNX.4.21.0005040912390.26262-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 3 May 2000, john peter grimes wrote:

>
> I was wondering if anyone had tried to compile KDE 2 lately.  I'm trying
> with yesterdays source and I get the error below in
> kdelibs/khtml/css
>
> I've got an almost standard linuxppc 2000 install which uses gcc-2.95.2-1g
>
> I can't find a report of this error on the kde web pages and looking at it
> I'm almost curious if it could be a problem with gcc for ppc (this file
> takes forever to compile) or some other ppc specific issue.
>

  Its a gcc bug, remove the -O2 option and this files will build
fine.

> Is anyone else compiling kde2, this is my first attempt.
> 					Thanks,
> 					John

   Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
