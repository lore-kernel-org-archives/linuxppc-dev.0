Message-ID: <385FF227.DEBE0159@broadlink.com>
Date: Tue, 21 Dec 1999 21:33:27 +0000
From: Scott Wood <scott@broadlink.com>
MIME-Version: 1.0
To: bsimon@ctam.com.au
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux-embedded: which shell, termcap or ncurses ?
References: <385EE46B.1D97C2D2@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan Simon wrote:

> I am trying to get a powerpc embedded system up and running.  I have
> compiled the kernel and can mount a root filesystem using initrd or
> nfs.  I now need to get a shell running so I can call shell scripts to
> setup the IP addresses etc via ifconfig (is there any other way ?).
> 
> I got the latest version of bash(2.0.3) and ncurses(5.0).  Bash requires
> termcap but apparently termcap is obsolete and is replaced by ncurses.
> 

You can still use an earlier 1.x version of bash which is linked to
libtermcap.
It will be much smaller and you probably don't need much functionality in
your 
shell if you're just setting up networking and running simple scripts.

> Has anyone cross-compiled a recent version of bash and ncurses ?  Are
> they huge ?  Will they fit on a 4MB initrd image ?

My bash, from the yellowdog distro, stripped, is about 400k.
If you're worried about space, strip all your binaries and libraries, 
and look at possibly using a more minimal shell like ash.

> 
> Thanks,
> Brendan Simon.

-- 
Scott Wood

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
