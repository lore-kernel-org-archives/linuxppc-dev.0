Message-ID: <38828BEE.CD5838A3@huawei.com.cn>
Date: Mon, 17 Jan 2000 11:26:38 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: Jim Lewis <jlewis@mvista.com>
CC: Brendan.Simon@ctam.com.au,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross-compile Applications for 860 on x86
References: <200001141101.MAA30605@denx.local.net> <387F0D81.48F7CABE@iname.com> <38827CD5.D7A44261@huawei.com.cn> <388292FB.4401C930@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




Jim Lewis wrote:

> dony wrote:
>
> > Hi,
> >
> > I download a older version of sash and now it works. It can run any built-in commands , but it fails to run
> > external programs , such as my test program "mytest". I put it both on / and /bin.
> > "-printenv" shows "PATH=/bin:/usr/bin:/etc". When I type "mytest" or "/bin/mytest" on the command prompt ">" , it
> > says "No such file or directory". And I cannot find some lines
> > about  "SASH"  in init/main.c.
> > Do you know why?
>
> Sounds like it  cannot find shared objects such as libc.so. You have two choices:
> 1) when you link the program, add the "-static" option

If I compile my test program which have only one "printf" line with "-static", It is about 1M size!  So I don't think
it's a good idea for me now.

>
> 2) put the necessary libraries in /lib

"rpc.nfsd -F -d call" says that it cannot find /etc/ld.so.cache and /etc/ld.so.preload. Yes, I have not these two files
after I decompress mbxroot.full.tgz.
Would you please send me a copy of these files? Thank you very much.h.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
