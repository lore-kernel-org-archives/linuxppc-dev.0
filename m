Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc1-s8.bay0.hotmail.com (bay0-omc1-s8.bay0.hotmail.com
	[65.54.246.80]) by ozlabs.org (Postfix) with ESMTP id E48F4DDE28
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Feb 2007 18:13:48 +1100 (EST)
Message-ID: <BAY115-W49EA8BA1CCA34CB8DA5E3B29D0@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: <christophe.alayrac@cresitt.com>
Subject: RE: ML403 Hard TEMAC, PLB and Linux 2.6
Date: Thu, 8 Feb 2007 07:13:47 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi
Thanks for reply
Well, regarding xapp902, there is a very simple question, Where can I find =
it? It seems that Xilinx has deleted all of the links to these files.=20





----------------------------------------
> Subject: Re: ML403 Hard TEMAC, PLB and Linux 2.6
> From: christophe.alayrac@cresitt.com
> To: mamsadegh@hotmail.com
> CC: linuxppc-embedded@ozlabs.org
> Date: Thu, 8 Feb 2007 06:51:45 +0100
>=20
> Le mercredi 07 f=E9vrier 2007 =E0 22:30 +0000, Mohammad Sadegh Sadri a
> =E9crit :
> Hi Mohammad,
>=20
> Please find here after some answer
>=20
> > 1- I want to use, ML403, Hard TEMAC and PLB TEMAC cores. Is there any r=
eady to use design, or any reference design available for this?
> > I'm using EDK 8.1 and I understood that, when I choose the ML403 board =
, EDK does not use hard temac, so , should I add it manually? ( well this i=
s funny, but the wizard does not use hard temac , is it true? )
> > Is there any ready EDK projects for ML403, with TEMAC and PLB TEMAC mod=
ules already inserted and cofigured? (I don't want to use GSRD ) ( If yes w=
ould you please put the link here )
> >=20
> You can start from XAPP 902 from Xilinx, this design demonstrate TEMAC
> use in loopback mode. Some memers from that community have tried from
> that design as a starting point. I did not nknow if the succeed.
> I would recommand to get EDK 8.2 SP2 and use the Wizard to build a new
> design with TEMAC.
>=20
> > 2- Simply, Is there any driver available for linux 2.6 , for PLB TEMAC =
and Hard TEMAC modules? If yes , can you put the link here, so that I can d=
ownload it?
> >=20
> For the kernel you can get it from Montavista source code site using GIT
> to download it (linux-xilinx-26). This is 2.6.17.4 version (last week!)
>=20
> Then you will need to pacth the Kernel with TEMAC drivers (look for
> TEMAC PAULUS MVISTA with google, or follow my messages in that mailing
> list)
> NOTE: If you use that TEMAC patch do not use SGDMA on your TEMAC, use
> FIFO.
>=20
> > thanks
> Regards
>=20
> Chris
> > _________________________________________________________________
> > Personalize your Live.com homepage with the news, weather, and photos y=
ou care about.
> > http://www.live.com/getstarted.aspx?icid=3DT001MSN30A0701
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20

_________________________________________________________________
Live Search: New search found
http://get.live.com/search/overview=
