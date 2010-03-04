Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id C1E3EB7CF1
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Mar 2010 00:28:17 +1100 (EST)
Received: by gwj20 with SMTP id 20so1265080gwj.15
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Mar 2010 05:28:15 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <16827431.1267696606015.JavaMail.ngmail@webmail13.arcor-online.net>
References: <1267640583.4760.0@antares>
	<fa686aa41003031307j79e004cfk49297e419a65f5da@mail.gmail.com>
	<16827431.1267696606015.JavaMail.ngmail@webmail13.arcor-online.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 4 Mar 2010 06:27:53 -0700
Message-ID: <fa686aa41003040527wdf794admd56fe5cf713ea4f8@mail.gmail.com>
Subject: Re: [Patch v.2] mpc5200b/uart: improve baud rate calculation (reach
	high baud rates, better accuracy)
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 4, 2010 at 2:56 AM, Albrecht Dre=DF <albrecht.dress@arcor.de> w=
rote:
>> That way each set_divisor() can do whatever makes the most sense for
>> the divisors available to it. =A0The 5121 for example has both a /10 and
>> a /32 divisor, plus it can use an external clock.
>
> Ouch. =A0I don't have a 512x, but isn't the current code plain wrong then=
? =A0It uses mpc5xxx_get_bus_frequency() as input for the baud rate calcula=
tion, and if the serial code assumes /16 instead of /10, the result must be=
 terribly off. =A0Or did I miss something here?

If you are, then I'm missing the same thing.  Do you best to keep the
5121 calculation work out to the same value it uses now.  We'll ask
someone with a 5121 to test it out before I add the patch to my -next
branch.

g.
