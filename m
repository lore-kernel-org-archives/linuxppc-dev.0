Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail177-sin-R.bigfish.com (mail-sin.bigfish.com [207.46.51.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1148ADE06E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jun 2007 05:52:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Audio Dirver for the 403/405?
Date: Thu, 31 May 2007 12:37:15 -0700
In-Reply-To: <10900170.post@talk.nabble.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "bert_maxel" <bonlutin@hotmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20070531193717.5743A1A48046@mail177-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


There is an opb core developed for the Xilinx University Program board,
which
has a similar hardware interface to the ML403 (i.e. no PCI bridge)
The XUPV2P web page with the opb_ac97 core is here:
http://www.xilinx.com/univ/xupv2p.html=20

I have a /dev/dsp driver (which I'll send to Bert directly) which limps
along in 2.6.
This core has a relatively small buffer and no master access to memory,
which
results in relatively poor performance, but it is a starting point.

Steve

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
> =20
> [mailto:linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@oz
labs.org] On Behalf Of bert_maxel
> Sent: Thursday, May 31, 2007 12:10 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: Re: Audio Dirver for the 403/405?
>=20
>=20
>=20
>=20
> Grant Likely-2 wrote:
> >=20
> > On 5/30/07, bert_maxel <bonlutin@hotmail.com> wrote:
> >>
> >> Hi all,
> >>
> >> Has anybody got some working audio driver (linux) for the =20
> ML403/405 ?
> >> I know it's an ac97 codec, but I can't find anything=20
> related to the=20
> >> xilinx boards?
> >> If nobody has worked on this yet, I'm in trouble. I don't=20
> know where=20
> >> to start, or from what ac97 driver should I base my=20
> initial development?
> >=20
> > IIRC, the old mvista 2.4 tree has an audio driver.
> >=20
> > g.
> >=20
> > --
> > Grant Likely, B.Sc., P.Eng.
> > Secret Lab Technologies Ltd.
> > grant.likely@secretlab.ca
> > (403) 399-0195
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >=20
> >=20
>=20
> There are plenty of boards with an ac97 codec, but what's=20
> missing is the glue for the ML403 board, there's no pci bus=20
> in this case,  opb cores instead.
> I hope somebody can point me to a link of interest.
>=20
> thanks
> --
> View this message in context:=20
> http://www.nabble.com/Audio-Dirver-for-the-403-405--tf3843165.
html#a10900170
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
