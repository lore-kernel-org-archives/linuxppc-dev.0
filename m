Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc3-s9.bay0.hotmail.com (bay0-omc3-s9.bay0.hotmail.com
	[65.54.246.209]) by ozlabs.org (Postfix) with ESMTP id D288BDDF75
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Apr 2007 00:52:45 +1000 (EST)
Message-ID: <BAY115-W63BB55D8630825D7BBEAFB24A0@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: <grant.likely@secretlab.ca>
Subject: RE: 2.6 Kernel , Xilinx Virtex and PPC 405 On chip memory
	controllers ( DSOCM and ISOCM )
Date: Tue, 24 Apr 2007 14:52:44 +0000
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



what about the cache?
Does the current kernel use the cache efficiently?



----------------------------------------
> Date: Tue, 24 Apr 2007 07:55:48 -0600
> From: grant.likely@secretlab.ca
> To: mamsadegh@hotmail.com
> Subject: Re: 2.6 Kernel , Xilinx Virtex and PPC 405 On chip memory contro=
llers ( DSOCM and ISOCM )
> CC: linuxppc-embedded@ozlabs.org
>=20
> On 4/24/07, Mohammad Sadegh Sadri  wrote:
> >
> > suppose that in my base system I have included 8kbytes of memory for DS=
 OCM and 8K for IS OCM,
> > I have generated the proper xparameters.h and copied it into kernel
> >
> > Now I want to know if kernel will use this portion of memory during it'=
s operation?
> > Does this increase performance?
>=20
> No, it won't use that memory as general purpose RAM.  You can make use
> of it in device drivers (ie. for DMA space), but you'll need to write
> the code to support it.
>=20
> Cheers,
> g.
>=20
> --=20
> Grant Likely, B.Sc. P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195

_________________________________________________________________
Connect to the next generation of MSN Messenger=A0
http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&sourc=
e=3Dwlmailtagline=
