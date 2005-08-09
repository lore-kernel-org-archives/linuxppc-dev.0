Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 4510E67F77
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 04:52:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 9 Aug 2005 13:52:33 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B85941C@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Wall clock accuracy
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Eugene Surovegin [mailto:ebs@ebshome.net]=20
> Sent: Tuesday, August 09, 2005 13:35
> To: Rune Torgersen
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Wall clock accuracy
>=20
> On Tue, Aug 09, 2005 at 01:21:09PM -0500, Rune Torgersen wrote:
> >=20
> > A proper fix would be for platfrom code to have a way to=20
> set time_nsec
> > instead of having it set by a constant.
>=20
> Or configure CLOCK_TICK_RATE in board/CPU specific fashion, e.g. like=20
> ARM does.

Then it would have to be a constant, and it would be much better to just
use the clockrate given to the kernel than have to hardcode it into the
kernel.
