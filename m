Date: Tue, 17 Jun 2003 11:26:42 +0200
From: Robert Schwebel <robert@schwebel.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: init does not run on 405GP system
Message-ID: <20030617092642.GE22306@pengutronix.de>
References: <20030610141047.GU9379@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20030610141047.GU9379@pengutronix.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jun 10, 2003 at 04:10:47PM +0200, Robert Schwebel wrote:
> Nevertheless, the kernel runs smoothly. I can ping the machine, I can
> even floodping it with 0% packet loss. Only that there is no userspace
> running.
>
> Has anybody seen something like this before?

It is solved. The On Chip Memory was mapped to an address below
0x8000'0000 - what we didn't know was that this is a _virtual_ address,
because the OCM is not simply located "behind" the MMU. After changing
the mapping it works smoothly now.

Robert
--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Braunschweiger Str. 79,  31134 Hildesheim, Germany
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
