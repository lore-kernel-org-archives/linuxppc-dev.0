Message-ID: <385818E1.D64FCFD6@ctam.com.au>
Date: Thu, 16 Dec 1999 09:40:34 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc-embedded: /bin/sh wont run from nfsroot.
References: <19991215055541.23843.qmail@web301.mail.yahoo.com> <385725A3.A1C110DF@ctam.com.au> <385774B8.3405494B@iname.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Chapman wrote:

> Make sure your 860 is a rev C part or higher. If it isn't, forget trying
> to use the cache.
>
> Your CPU is a regular 8xx, not a 'P' (performance) variant, right? The
> latter has "optimized" cache hardware that isn't (yet?) supported by
> linuxppc.

It's an XPC860SRZP50C1.  I have another board with no ethernet which has an
XPC860ZP33C1 or an XPC860DEZP25A3 (this is on an older board).

The XPC860SRZP50C1 is a SAR processor though we are not using any of the SAR
capabilities on this board.  I hope this processor is fine.


> Do you have a /bin/sh on your initrd? You'll need the shared libraries
> too.

I think the one I have is statically linked so I shouldn't need any shared
libraries.  It is the one that is in the mbx-root-min.tgz file.  The shell works
fine if I use initrd so it should work fine from an nfsroot (I would assume).


> Also, try running your NFS server in the foreground in a debug mode if
> it isn't being used by other hosts. This will display exactly what files
> are being accessed. You should see lots of directories, shared libraries
> etc being read. I use
>
> # rpc.nfsd -F -d call
>
> but obviously kill any running nfsd first.

Now there is a good idea.  It's so obvious.  Why didn't I think of that.
Thanks.

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
