Message-ID: <38583159.AF0E44C9@ctam.com.au>
Date: Thu, 16 Dec 1999 11:24:58 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: linuxppc-embedded: /bin/sh wont run from nfsroot.
References: <19991215055541.23843.qmail@web301.mail.yahoo.com> <385725A3.A1C110DF@ctam.com.au> <385774B8.3405494B@iname.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Chapman wrote:

> Also, try running your NFS server in the foreground in a debug mode if
> it isn't being used by other hosts. This will display exactly what files
> are being accessed. You should see lots of directories, shared libraries
> etc being read. I use
>
> # rpc.nfsd -F -d call

I did this.  It seems that /bin/sh is found and that the file /lib/ld.so.1 is
being read, but it just stops.  I don't know if the 860 has crashed or what ?  I
will try running a program via an nfs mount from another linux box and see what
the nfsd debug output should look like.  Other than that I'm lost.  Any ideas
how I can test the reliability of the ethernet driver on the 860 system ?

Is it possible to use kgdb in anyway.  I have never used kgdb before so I'm not
sure what it can do for me.

Thanks,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
