Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <006601c3c00b$1eefa160$0400a8c0@eurostudio.local>
From: "AlessandroPPC" <aleppcrossi@libero.it>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20031210210608.03D20C5F5F@atlas.denx.de>
Subject: R: self image 
Date: Thu, 11 Dec 2003 18:20:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Your new filesystem is twice as big as the old one, so it  will  have
> more inode blocks etc.

Many thanks, everything is working fine.


Just one more question: when I add the "top" program (and related library)
to the filesystem, and I try to run it, the following message appears before
exit:

top: Unknown terminal "xterm" in $TERM

Any idea how to solve it?

Thanks in advance

Alessandro


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
