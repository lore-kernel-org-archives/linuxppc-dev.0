Return-Path: <wmb@firmworks.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4A1C7B7BCA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 08:45:52 +1000 (EST)
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9425DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 08:45:51 +1000 (EST)
Message-ID: <4A970C85.8090703@firmworks.com>
Date: Thu, 27 Aug 2009 12:45:25 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] Clock binding
References: <1250569288.19007.15.camel@pasglop>	
	<1251346157.20467.22.camel@pasglop>
	<4A96F69A.5050003@firmworks.com>
	<1251411532.20467.74.camel@pasglop>
In-Reply-To: <1251411532.20467.74.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
>> > One advantage of indices is that they avoid endless arguments about the 
>> > exact name (and spelling) of things.
>>     
>
> Right, though in that case, nobody gets to have to decide on the name,
> it comes from the chip manufacturer pin naming or data sheet.
>
>   


I agree in general.  It has long been a convention of mine to follow the 
vendor's names as exactly as possible.  But that often presents 
difficulties. Many of them have been touched on in our previous 
discussion but I'll list some here just to emphasize the problem we face:

a) Inconsistent naming within a vendor's documentation set - datasheet 
spells it one way, programmer's manual another, appnotes/porting guide 
still another, reference schematic spells it two different ways (pin 
name on part versus net name of signal wire).

b) Sometimes the name is abbreviated and sometimes spelled out.  SMBALRT 
vs. SMbus Alert.

c) Different tools (CAD programs, word processors) have different 
conventions leading to existence of ambiguously-representable name 
components - particular cases in point are overbars for active low 
signals and embedded spaces/underscores/hyphens in names.

d) Compatible part from different vendors leads to confusion about which 
vendor's names are canonical.  Or leading vendor goes out of business or 
gets bought.

These problems are getting worse rapidly as more devices are being 
sourced from Asia, where the linguistic connection to the Roman alphabet 
is tenuous.

You need a Pope to decide what is canonical.
