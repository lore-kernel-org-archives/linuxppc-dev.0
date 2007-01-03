Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D0733DDF35
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jan 2007 08:02:28 +1100 (EST)
In-Reply-To: <1167857446.6165.155.camel@localhost.localdomain>
References: <20070103185628.GE6279@localdomain>
	<1167857446.6165.155.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fb980819604330703711fd6b55dea46d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] maple: improve CPC9x5 host bridge detection
Date: Wed, 3 Jan 2007 22:02:55 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Identify CPC9x5 PCI Express, AGP, and HT host bridges using
>> device_type and compatible properties, which is a more flexible method
>> than using the name property (which can differ between firmwares and
>> models).
>>
>> Signed-off-by: Nathan Lynch <ntl@pobox.com>
>
> Do that work on js20/js21 with SLOF ?

It should, you might want to check recent versions though.


Segher
