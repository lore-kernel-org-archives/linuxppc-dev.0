Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id B84FDDDFC6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jul 2008 08:10:27 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KJy9h-0003Uh-0x
	for linuxppc-embedded@ozlabs.org; Fri, 18 Jul 2008 15:10:25 -0700
Message-ID: <18538522.post@talk.nabble.com>
Date: Fri, 18 Jul 2008 15:10:25 -0700 (PDT)
From: Victor Gallardo <vgallardo@amcc.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Add AMCC Arches DTS
In-Reply-To: <200807181624.10338.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <1216186476-28018-1-git-send-email-fkan@amcc.com>
	<200807181624.10338.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> So its a S29GL256 with 32MBytes...

Yes.

> ... and this partition scheme is for 64MByte.

You, you are correct. I'll fix this.

> <snip>
>
>> +			EMAC0: ethernet@ef600e00 {
>> +				device_type = "network";
>> +				compatible = "ibm,emac-460gt", "ibm,emac4";
>
>That's not correct anymore. A recent patch from Grant Erickson
[ibm_newemac: 
>Parameterize EMAC Multicast Match Handling] changed these compatible
entries. 
>You should use "ibm_emac4sync" here now.

OK. Will change.

>> +				interrupt-parent = <&EMAC0>;
>> +				interrupts = <0 1>;
>> +				#interrupt-cells = <1>;
>> +				#address-cells = <0>;
>> +				#size-cells = <0>;
>> +				interrupt-map = </*Status*/ 0 &UIC2 10 4
>> +						 /*Wake*/   1 &UIC2 14 4>;
>> +				reg = <ef600e00 70>;
>
> The patch mentioned above also fixed the incorrect size here. Please fix
> this 
> too.

Ok. Will fix.

>SGMII, right?

Yes, that is correct. I will fix this also.

Thanks Stefan,

Victor Gallardo

-- 
View this message in context: http://www.nabble.com/-PATCH--Add-AMCC-Arches-DTS-tp18480767p18538522.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
