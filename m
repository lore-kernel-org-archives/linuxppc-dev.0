Return-Path: <jonb@marel.is>
Received: from marel.marel.is (GW-NAT01-ISLNET.marel.is [213.213.131.1])
	by ozlabs.org (Postfix) with ESMTP id 045FE2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Nov 2004 01:13:23 +1100 (EST)
In-Reply-To: <20041104162302.2B49DC1430@atlas.denx.de>
To: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Message-ID: <OF5D3B44B5.3530BFCD-ON00256F43.0035B584-00256F43.004E2C6C@marel.is>
From: "=?iso-8859-1?Q?J=F3n_Benediktsson?=" <jonb@marel.is>
Date: Fri, 5 Nov 2004 14:13:51 +0000
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Handling power failure - MPC5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> In message <OF368071C2.FBC6B7BC-ON00256F42.003F3DF3-00256F42.
> 0044E8BB@marel.is> you wrote:
> >=20
> > Capacitors on the supply provide me with some milliseconds to repond=20
to=20
> > power failure, which I would
> > like to use to do as much cleanup as possible before power is totally=20
> > gone.  In particular, I am concerned
>=20
> How many is "some"? If it's not >100 or so it is probably  not  worht
> the effort...

With the current design "some" is <50, but we can change the design if
we find it necessary.
=20
>=20
> Use the standard methods: use the CF card read-only  (many  CF  cards
> can  be  damaged  [beyond  repair]  when  you power off while a write
> operation is in progress).

Is this an acknowledged fact by CF manufacturers or based on experiece ?

Thank you very much for your input.

Regards,
J=F3n Benediktsson
Marel hf.
