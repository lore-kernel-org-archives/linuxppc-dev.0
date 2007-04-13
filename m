Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 180CBDDFF0
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 05:10:21 +1000 (EST)
In-Reply-To: <461FD318.4070102@ru.mvista.com>
References: <91308d2b933e4fe8a9618aef8748b878@bga.com>	<1176431001.5764.51.camel@localhost.localdomain>
	<a6845fee0c7e5d306f93d0ed71d46b5a@kernel.crashing.org>
	<461FD318.4070102@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f292b60023b81b7d66b414ad6fbd5b01@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Re: 
Date: Fri, 13 Apr 2007 21:10:17 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Olaf Hering <olaf@aepfle.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> I think the proper test is ((cb & 5) == 5) but I can't remember for
>>> sure..
>> That is correct if you know for sure the controller
>> actually supports native mode, and doesn't have that
>> support turned off by some configuration setting;
>> otherwise, the test should be ((cb & 0xf) == 0xf).
>
>   "I protest your honor". :-)
>   Bits 1 and 3 only indicate that bits 0 and 2 are writeable.

Darn you're right.  Sorry for the confusion.


Segher
