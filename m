Message-ID: <3739F32D.E4A5BD10@wanadoo.fr>
Date: Wed, 12 May 1999 23:31:25 +0200
From: Martin Costabel <costabel@wanadoo.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: Tom Rini <tmrini@ntplx.net>
CC: Konstantinos Margaritis <kmargar@cc.uoa.gr>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: cvs kernel does not compile
References: <Pine.LNX.4.05.9905121539420.651-100000@pc.wackyland.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
> 
> On Wed, 12 May 1999, Konstantinos Margaritis wrote:
> 
> >    The 2.3.0 kernel found on cvs.on.openprojects.net does not compile on
> > my powerpc system (debian glibc 2.1, egcs 1.1.2pre), with the following
> > error:
> 
> Welcome to the dev cycle.  The tree can be broken once again, and only has
> to compile on x86.  I'm sure Cort or someone will see what's going to be
> needed to fix up 2.3.1-pre2 soon enough.

2.3.0 (cvs) compiled fine for me this morning, I'm running it now
(LinuxPPC R5 beta):

root[8]#dmesg | grep Linux
Linux version 2.3.0 (root@chezmoi) (gcc version egcs-2.91.66 19990314
(egcs-1.1.2 release)) #14 Wed May 12 09:30:40 CEST 1999

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
