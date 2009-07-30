Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A789EB7B61
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 15:25:00 +1000 (EST)
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id 3EC16DDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 15:24:59 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	CA1E731A16F
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 07:24:56 +0200 (CEST)
Received: from [192.168.1.6] ([87.97.88.130])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KNK00DFYXPH6680@invitel.hu> for
	linuxppc-dev@ozlabs.org; Thu, 30 Jul 2009 07:24:56 +0200 (CEST)
Date: Thu, 30 Jul 2009 07:29:46 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: 82xx, mgcoge: updates for 2.6.32
In-reply-to: <20090729103203.GA6369@yookeroo.seuss>
To: david@gibson.dropbear.id.au
Message-id: <4A712FCA.9070105@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <4A70091E.7000002@denx.de> <20090729103203.GA6369@yookeroo.seuss>
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello David,

David Gibson wrote:
> On Wed, Jul 29, 2009 at 10:32:30AM +0200, Heiko Schocher wrote:
> 
> [snip]
>> +			mdio@10d40 {
>> +				device_type = "mdio";
> 
> Drop this device_type.

Done.

>> +				compatible = "fsl,cpm2-mdio-bitbang";
>> +				reg = <0x10d00 0x14>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				fsl,mdio-pin = <12>;
>> +				fsl,mdc-pin = <13>;
>> +
>> +				phy0: ethernet-phy@0 {
>> +					reg = <0x0>;
>> +					device_type = "ethernet-phy";
> 
> And this one, too.

Done.

>> +				};
>> +
>> +				phy1: ethernet-phy@1 {
>> +					reg = <0x1>;
>> +					device_type = "ethernet-phy";
>> +				};
>> +			};
> 

I collect more comments, then the patch follows.
Thanks
bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
