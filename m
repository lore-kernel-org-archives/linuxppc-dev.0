Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8FA3CDDFC6
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 08:18:05 +1000 (EST)
In-Reply-To: <200705032103.33809.arnd@arndb.de>
References: <20070503065435.4533.64938.stgit@localhost.localdomain>
	<200705030948.03984.arnd@arndb.de>
	<5a7e02f6d1520d8ad02e28ace218981c@kernel.crashing.org>
	<200705032103.33809.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <162630d74e53bc10840b667973122fff@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 8xx: mpc885ads pcmcia support
Date: Fri, 4 May 2007 00:17:39 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> For example, you could make this
>>>
>>> =A0=A0=A0=A0=A0=A0compatible =3D "8xx\0mpc885ads";
>>
>> "mpc885ads-pcmcia\0mpc8xx-pcmcia" or something like that.
>
> Right. I can never remember what goes first...

It doesn't really matter all that much; "correct"
drivers probe for the most specific thing first,
then the next most specific thing they support,
etc.  It is mostly a convention.

The important thing is that you can't just call
yourself "8xx", that is way to generic a name.


Segher
