Message-Id: <l03130300b3cf9d4b53d0@[209.226.106.188]>
In-Reply-To: 
 <Pine.LNX.4.10.9907211505370.15642-100000@mercator.cs.kuleuven.ac.be>References:
 <Pine.LNX.4.10.9907111312360.392-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 5 Aug 1999 16:10:59 -0400
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev@lists.linuxppc.org
From: Eric Dorland <dorland@lords.com>
Subject: Re: Problems with the atyfb driver on Power Mac G3
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>And so I did: not the GUI thing, but a small command line utility. And a patch
>for atyfb, of course:
>
>    http://www.cs.kuleuven.ac.be/~geert/bin/atyfb_dsp_debug.tar.gz

I finally got a chance to apply this patch to my kernel (thanks very much
Geert:). The patch applied cleanly to the 2.2.10 kernel and compiled with
no problems. The atyclk program compiled fine as well, but whenever I try
to use it I get the error:

ioctl ATYIO_CLKR: Invalid argument

Have I missed something? Has anyone else gotten the patch to work?

Eric Dorland
mailto:dorland@lords.com



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
