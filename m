MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Can I run linux without a file system? 
Date: Fri, 21 Jun 2002 16:46:24 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E106401281423@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
> In message
> <45B36A38D959B44CB032DA427A6E10640167CFE3@cceexc18.americas.cpqcorp.net> you wrote:
> >
> > Hmm, my minimal rootfs is (so far) 7 Mb,
[...]
> Have a look at the SELF Makefile... you should run
>
> $(CROSS_PREFIX)strip --remove-section=.note --remove-section=.comment *.so

Whoa! That is better.  ~2.8 Mb now, as reported by du. Thanks!

-- steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
