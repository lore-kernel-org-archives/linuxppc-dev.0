From: clark@esteem.com
Message-Id: <1.5.4.32.20000721160550.0068bee4@pop.esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 21 Jul 2000 09:05:50 -0700
To: "Paolo Scaffardi" <arsenio@tin.it>
Subject: Re: What kernel for a MPC823FADS and PCMCIA?
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 10:21 AM 7/21/00 +0200, you wrote:
>
>I have a MPC823FADS and i want to make a simple Linux box with ETHERNET and
>PCMCIA support.
>
>What is the right kernel to use and patches to make the PCMCIA working on
>the board?
>
>I'm very confused... i probably had to buy another board... MVista doesn't
>support my board... why?!?!?!
>
>Bye,
>Paolo.
>
>

        Paolo,

        You need to get the pcmcia suport package called
pcmcia-cs-3.1.10.tar.gz or what ever the newest one is. You can find it and
some patches and instructions on how to get it to work with a RPX LITE 823
board at ftp://ftp.absoval.com/pub/rpxlite/ . You may have to tweak it to
work with your board. I'm sorry I can't be more help to you from here,
because this is the stage I am at.


        Good Luck,

        Conn Clark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
