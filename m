Message-ID: <00a601c470cd$94f5cd80$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Pantelis Antoniou" <panto@intracom.gr>,
	"Robert P. J. Day" <rpjday@mindspring.com>
Cc: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
References: <20040723133703.1A753C109F@atlas.denx.de> <Pine.LNX.4.60.0407230947570.5108@localhost.localdomain> <410123EE.4000602@intracom.gr>
Subject: Re: random ramblings on 8xx patches (long and tedious :-)
Date: Fri, 23 Jul 2004 11:56:07 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> The family should be sufficient (say 8xx).
>
> Then everything should be automatically set up at run-time, based
> on probing code which should detect the rest.
>
> That's what OCP should do ideally when it is ready.
>
> In this day and age wasting 50k to kill every-single last
> ugly define in drivers or the setup code is worth it; again IMHO.
>

This sounds like a good idea, especially since the setup code can probably
be thrown away after startup.  However, does this fully solve the problem?
For instance if the user is deciding whether to include a UART or USB driver
for SCC3 doesn't he needs to know at that time whether it's on chip or not?
Perhaps udev handles this situation?

Mark Chambers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
