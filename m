Mime-Version: 1.0
Message-Id: <v04205501b39d320ee274@[206.173.236.183]>
Date: Mon, 28 Jun 1999 07:11:08 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Randall R Schulz <rrschulz@cris.com>
Subject: The Kernel Known as vmlinux.blueg3
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I have a question and an observation on the kernel "vmlinux.blueg3" 
distributed with R5/1999:

Q: What sources and configuration options are necessary to build this kernel?

O: Although the GZIP'ed files vmlinux.blueg3 and vmlinux.blueg3v2 
have different sizes on the servers that carry them, once unzipped 
they checksum identically. Presumably the different size of the 
GZIP'ed form reflects different compression setting. Oddly, I read 
one report of someone who claimed one of them work better or 
differently than the other. Presumably that was due to some other 
issue.

Thanks.

Randy Schulz
Mountain View, CA

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
