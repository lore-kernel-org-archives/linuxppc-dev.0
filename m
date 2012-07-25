Return-Path: <B10812@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 55A292C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 22:08:54 +1000 (EST)
From: Aggrwal Poonam-B10812 <B10812@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>, Singh Sandeep-B37400
 <B37400@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [1/3][PATCH][upstream]Adding documentation for TDM
Date: Wed, 25 Jul 2012 12:08:40 +0000
Message-ID: <ACB6D0C0104CFF42A45A5D82A0DD4F3D079B926B@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1343040588-16002-1-git-send-email-b37400@freescale.com>
 <1343040588-16002-2-git-send-email-b37400@freescale.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B6FA4@saturn3.aculab.com>
 <ACB6D0C0104CFF42A45A5D82A0DD4F3D079B7B35@039-SN2MPN1-013.039d.mgd.msft.net>
 <AE90C24D6B3A694183C094C60CF0A2F6026B6FA8@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B6FA8@saturn3.aculab.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Singh Sandeep-B37400 <B37400@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: David Laight [mailto:David.Laight@ACULAB.COM]
> Sent: Wednesday, July 25, 2012 2:14 PM
> To: Aggrwal Poonam-B10812; Singh Sandeep-B37400; linuxppc-
> dev@lists.ozlabs.org
> Cc: Singh Sandeep-B37400
> Subject: RE: [1/3][PATCH][upstream]Adding documentation for TDM
>=20
> > > For flexibility you need to allow for 8bit samples being converted
> as:
> > > 1) 8bit raw ulaw or alaw data (unchanged from line).
> > > 2) 8bit raw data, bit reversed, any hdlc protocol
> > >    is bit reversed from audio [1].
> > > 3) 8bit audio, converted from alaw to ulaw
> > > 4) 8bit audio, converted from ulaw to alaw
> > > 5) 16bit linear converted to/from alaw or ulaw and on a per-timeslot
> > > basis.
> > I agree. That we only support very limited samples. But We can add
> this
> > in second step once the basic framework is in.
> > Also right now the testing infrastructure we have, we won't be able to
> > test all these scenarios.
>=20
> You probably ought to make the application request a specific format -
> and error the unsupported ones.
> That would make it easier to add support for other formats later.
David there is still configuration interface which needs to be added to the=
 Framework.
This is mentioned in the documentation and patch also.
But we really need the core stuff which is handling the data get in and thi=
ngs will be added subsequently.=20
>=20
> I also suspect that this 'framework' isn't that general!
All the feedback welcome!
> We (as a company) use the TDM interface blocks on the MSC8101 and MSC8013
> Starecore DSPs as well as some bespoke FPGA logic (which will do ulaw<-
> >alaw convertion).
> The 'framework' would almost certainly be inappropriate for both out
> hardware and software.
Thanks a lot for the feedback. Can you please help to understand what is th=
e scenario and how you use TDM. This will be a big help.
More generic the better.

Regards
Poonam
>=20
> 	David
>=20
>=20
>=20
