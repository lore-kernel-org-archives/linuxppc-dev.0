Message-ID: <3CB53ACE.4070603@bluewin.ch>
Date: Thu, 11 Apr 2002 09:27:10 +0200
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: sporadic kernel panic during boot (MPC8xx, FEC)
References: <3CB53640.9B0DD9B4@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 04/11/2002 09:07 AM, Steven Scholz wrote:

>Hi there,
>
>I am using the linux kernel from bitkeepers linuxppc_2_4_devel exported
>as of -rv2.4.18 on a MPC855T based board.
>
AFAIK, this relase tag applies ony to Linus's part of the tree.
The PPC part is somehow undefined and might be quite old.
I usually search "bk changes" for "v2.4.18" and then take a
change-set shortly afterwards e.g.:

  bk export -r1.900 <path>

Hope it helps,

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
