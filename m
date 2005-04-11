Return-Path: <Marc.Howard@KLA-Tencor.com>
Received: from CA1EXBH01.adcorp.kla-tencor.com (mailout01.kla-tencor.com
	[192.146.1.171]) by ozlabs.org (Postfix) with ESMTP id AB69267B1C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 04:30:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 11 Apr 2005 11:30:32 -0700
Message-ID: <91B22F93A880FA48879475E134D6F0BEBDE4B2@CA1EXCLV02.adcorp.kla-tencor.com>
From: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
To: "Embedded PPC Linux list" <linuxppc-embedded@ozlabs.org>
Subject: RE: cross-compiling under cygwin? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang,

It has a /dev filesystem but exporting it doesn't work.  Yes, user and
group ids are supported and it can either be from group/passwd files or
NIS.  It does have hard and soft links.  It is a pretty extensive port
(formerly known as Internix).

It is a solution for environments that have IT departments full of
Micro$soft trained robots located an ocean away who will only allow
installation of Redmond-blessed add-ons.

I'm not pushing it as a solution but it is a free way to have a mount a
NFS-style filesystem on an embedded linux board.  I believe I did
mention that I disliked recommending it but to deny it exists would be
censorship.

Marc W. Howard

> -----Original Message-----
> From: wd@denx.de [mailto:wd@denx.de]=20
> Sent: Sunday, April 10, 2005 9:59 AM
> To: Howard, Marc
> Cc: Embedded PPC Linux list
> Subject: Re: cross-compiling under cygwin?=20
>=20
> In message=20
> <91B22F93A880FA48879475E134D6F0BEB9C02A@CA1EXCLV02.adcorp.kla-
> tencor.com> you wrote:
> >=20
> > Yes you can run NFS on Windows.  The systems we ship inside our
> > equipment have a Win2k Server host and the embedded boards=20
> hang off of
>=20
> And this really supports things like special files,  user  and  group
> id's, permissions including set-uid and hardlinks and all that?
>=20
> Best regards,
>=20
> Wolfgang Denk
>=20
> --=20
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> Hello! I'm from outer space,  and I've made myself look like a signa-
> ture.  While  you  are reading this, I'm having sex with your eyes. I
> know it feels good to you, because you're smiling. I'm very horny, so
> send me to someone else when you've had enough. Thanks!
>                               Sincerely, A Stranger in a Strange Land
>=20
