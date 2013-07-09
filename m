Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9B7632C013D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 02:09:39 +1000 (EST)
Date: Tue, 9 Jul 2013 11:09:22 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: =?UTF-8?b?562U5aSNOiDnrZTlpI06?= [PATCH 2/2] powerpc/85xx: add
 the P1020RDB-PD DTS support
To: Zhang Haijun-B42677 <B42677@freescale.com>
In-Reply-To: <99E897753B6F7048BD8CCDB4661D02E1396F13@039-SN2MPN1-021.039d.mgd.msft.net>
 (from B42677@freescale.com on Tue Jul  9 00:34:34 2013)
Message-ID: <1373386162.8183.189@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Huang Changming-R66093 <r66093@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Xiaobo-R63061 <r63061@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2013 12:34:34 AM, Zhang Haijun-B42677 wrote:
> > cpld@2,0 {
> >           compatible =3D "fsl, p1020rdb-cpld";
> >           reg =3D <0x2 0x0 0x20000>;
> >           read-only;
> > };
>=20
> Again, what is read-only supposed to mean here?  I don't care that =20
> it's
> copied from the PC version.  It doesn't make sense, and is not
> documented in a binding.
>=20
> Mostly CPLD only used to read configuration from. Supposed not been =20
> changed.

The device tree describes the hardware, not the intended use (the =20
partition stuff is not a good example).  Plus, any property you use =20
must be documented in a binding.

And please use proper quoting in your e-mail replies.  Don't just =20
insert your response as if it were part of what I wrote.  You should be =20
able to make your e-mail client do this automatically (if you can't, =20
get a new e-mail client).

-Scott=
