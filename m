Message-Id: <v04003a0db842c0b7e250@[24.70.162.28]>
In-Reply-To: <p04330105b8428baee0fe@[24.163.44.170]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 16 Dec 2001 15:24:55 -0600
To: Stefan Jeglinski <jeglin@4pi.com>,
	linuxppc-dev@lists.linuxppc.org
From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
Subject: Re: ethtool failure with tulip 21143
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:53 AM -0600 12/16/01, Stefan Jeglinski wrote:
>I have a PowerPC 6500 with a Farallon 10/100 PCI card connected to a
>Netgear 10/100 switch. I have never gotten this card to work right in
>this box. If the number of packets is small, the connection seems to
>work, but any increase in the number of packets (my theory) causes
>the interface/NIC to choke up. I'm using 2.4.14 (bk).
[...]

I had the same problem with the Farallon 10/100 card in my 9600. It seemed
that either the driver or the chip weren't talking FDX properly - the card
worked flawlessly at 100/HDX.

I never figured out how to twiddle the duplex setting in the driver itself,
I usually ended up unplugging and replugging the ethernet cable a few times
until I confused the nway into thinking half-duplex is a good idea.

This was using the 'tulip' driver, iirc. I never had much luck with the
de4x5 driver. I haven't booted linux on my 9600 in a while, though, so
things might have improved since then.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
