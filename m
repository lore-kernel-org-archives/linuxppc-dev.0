Message-ID: <3C95E56F.765DDEF8@imc-berlin.de>
Date: Mon, 18 Mar 2002 14:02:39 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: not enough memory for SELF!?
References: <20020318125418.7C3E1109F1@denx.denx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for your reply!

> There are several options:
>
> * Add more RAM (which is obviously the  simplest  solution  from  the
>   perspective of a software developer)
I will!

> * Reduce the size of the ramdisk - it defualts to  4  MB,  but  AFAIR
>   only about 2.5 MB are used
How? My pRamdisk is only 955068 bytes large.

> * Don't use a ramdisk at all, but instead put  your  root  filesystem
>   into a cramfs or JFFS2 filesystem
Hmm? Is there a HOWTO for doing this?

Thanks,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
