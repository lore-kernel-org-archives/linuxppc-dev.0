Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F40AB7BBB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 03:57:48 +1100 (EST)
Message-ID: <49404.84.105.60.153.1259168264.squirrel@gate.crashing.org>
In-Reply-To: <4B0AE865.4030502@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221518s5d82d5b4i8402a297d52a46d1@mail.gmail.com>
	<4B0AE865.4030502@yahoo.es>
Date: Wed, 25 Nov 2009 17:57:44 +0100 (CET)
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Albert Herranz" <albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> +               i2c-video {
>>> +                       #address-cells = <1>;
>>> +                       #size-cells = <0>;
>>> +                       compatible = "virtual,i2c-gpio";
>>
>> There isn't a documented binding for this.  Is there a driver for it?
>>
>
> I have a driver for it. But it isn't yet published.

I bet there already is a generic IIC-via-GPIOs driver that
you could use.


Segher
