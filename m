Message-ID: <3673C8FA.3F298C09@mail.esiea.fr>
Date: Sun, 13 Dec 1998 15:02:35 +0100
From: "G. =?iso-8859-1?Q?Laur=E8s?=" <laures@hp1.esiea.fr>
Reply-To: laures@hp1.esiea.fr
MIME-Version: 1.0
To: Liste LinuXppc/user <linuxppc-user@lists.linuxppc.org>,
        Liste LinuXppc/Samba <linux-pmac@samba.anu.edu.au>,
        Liste LinuXppc/dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: LinuxPPC and a 2nd ethernet card
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Richard West a *crit :
> 
> Ok.. Trying to get ip masquerading to work and all, so I went out and bought
> another ethernet card.  Well, my question now is:
> How do I get this card to be recognized by Linux?
> 
> It's a MacSense 10/100 card.
Mine is a FE551, works with the RealTek 8139 drivers, you just have to
compile your kernel with the RealTek 8139/8129 drivers checked.

> 
> But I am not sure.. the other chip on the board is covered with a MacOS
> label that is rather adhered to the surface of the chip. :)
This is the RealTech chip, the other is a kind of terminator I believe



GoM

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
