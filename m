In-Reply-To: <v04204e0eb35f112116ec@[206.163.71.146]>
Date: Mon, 10 May 1999 14:54:49 +0200
To: Joel Klecker <jk@espy.org>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Does Linux PPC support the new 'Lombard/101' Powerbook G3s?
Message-Id: <19990510145449.006703@sjc2-relay.mail.digex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 12, 1999, Joel Klecker <jk@espy.org> wrote:

>On a unsupported hardware note: the ethernet controller is a DP83843 
>PHYTER made by National Semiconductor, which will need a driver 
>written for it.


The note is confusing, but  think this is just the physical layer. I
didn't have a chance to look at the device tree for those machines yet,
but it looks like the motherboard is very similar to the iMac's one.
The Apple ASIC is a paddington, so I beleive ethernet is a bmac+. Almost
everything should work out of the box, the only potential problem I can
see would be possible changes to the PMU device (named "Cuda PMU" on the
developer note, but I'm pretty sure it's still the old PMU we all know
and hate ;-)


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
