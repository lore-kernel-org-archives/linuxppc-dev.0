Message-Id: <l03130300b3affd741b92@[209.226.106.88]>
In-Reply-To: <l03130300b3aecf951ee8@[209.226.106.137]>
References: <14214.22225.201034.85545@cpu.wpi.edu>
 <v04011704b3ab5f3e0860@[199.174.193.13]>
 <Pine.LNX.4.10.9907021615070.17139-100000@mercator.cs.kuleuven.ac.be>
 <v04011702b3a0ce93e160@[199.174.101.193]>
 <v04011704b3ab5f3e0860@[199.174.193.13]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 12 Jul 1999 16:21:12 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Eric Dorland <dorland@lords.com>
Subject: Re: Problems with the atyfb driver on Power Mac G3 (Possible fix)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>This patch works for me...
>
>It works for me too! I'm so happy! Thanks Tim!

It appears I spoke too soon :( The patch does appear to work flawlessly
when in video mode 13 (832 x 624) but in video mode 15 (1024 x 768) still
has snow. I'm still happy, because I use vmode 13 primarily, but the
problem is not 100% fixed. I think an ioctl, to fiddle with the values,
would still be helpful.

Eric Dorland
mailto:dorland@lords.com



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
