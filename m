Date: Thu, 15 Nov 2001 19:06:23 +0100
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Subject: Re: linuxppc_2_4_devel on walnut
To: Armin Kuster <akuster@mvista.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3BF4041F.A732B099@inn.ericsson.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <3BDD855B.8D3FC72F@inn.ericsson.se>
 <3BE971BC.34591FF1@inn.ericsson.se> <3BEBF4E5.B60BD9E3@inn.ericsson.se>
 <3BF2A361.5FBB0246@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Armin Kuster wrote:
>
> Kenneth Johansson wrote:
> >
> > But the ethernet reporting of the line is wrong. This is a problem with the
> > printout only as the function is right. The 100Mb full duplex is reported to
> > be 10Mb half and vise verse.
> >
>
> Kenneth;
>
> I finally got arround to looking into this and the problem is the
> status.
> We use the status to program the emac to the same speed as the PHY.
>
> I have attach a patch the should correct this.

I saw that this was also in the devel tree so I updated my copy and yes the
printout is now right.

But "time dd if=/dev/zero of=testing bs=1024k count=100" on a nfs mouted fs
used to be 18s and is now 21s, a 16% slowdown not that I care much but still
quite a large difference.

And I have not tired this on my 10Mb port yet as I still have only one active
but as soon as they work again I test on 10Mb.

--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
