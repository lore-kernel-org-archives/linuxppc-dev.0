Return-Path: <tlopez@aotek.es>
Received: from smtp2.sarenet.es (orhi.sarenet.es [192.148.167.5])
	by ozlabs.org (Postfix) with ESMTP id DA27468AA2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jan 2006 21:48:31 +1100 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by smtp2.sarenet.es (Postfix) with ESMTP id 533B76AEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jan 2006 11:23:46 +0100 (CET)
Message-ID: <43D751F8.9060204@aotek.es>
Date: Wed, 25 Jan 2006 11:24:56 +0100
From: Txema Lopez <tlopez@aotek.es>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH] Add support for lite5200b board.
References: <43D65FE3.6080501@freescale.com> <43D66F54.8000404@246tNt.com>
In-Reply-To: <43D66F54.8000404@246tNt.com>
Content-Type: multipart/mixed;
	boundary=------------040508050407030806050808
Cc: John Rigby <jrigby@freescale.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040508050407030806050808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi ,

Sylvain Munaut wrote:

>Hi John,
>
>John Rigby wrote:
>  
>
>>Sylvain,
>>
>>Here is an updated patch for the liteb board.
>>
>>John
>>    
>>
>
>  
>
We have a Lite5200b and are very interesting in this point.

For wich kernel version is this patch?

>Looks good. But two comments :
>
> * Isn't a modif to the arch/ppc/platform/Makefile missing ?
> * What's the "cs-1" you turn on there :
>
>  
>
>> 
>>+#ifdef CONFIG_LITE5200B
>>+	/* turn on cs1 */
>>+	port_config |= 0x80000000;
>>+#endif
>>    
>>
>
>  
>
What fix this ?

>	I couldn't find the schema / real-doc of the Lite5200b,
>is this available somewhere on-line ?
>
>
>
>  
>
Sylvain, I don't know if there are some Lite5200b doc on line, but I 
have the schematics and could send to you or to anyone who want it.

>	Sylvain
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  
>


--------------040508050407030806050808
Content-Type: text/x-vcard; charset=utf-8;
 name="tlopez.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="tlopez.vcf"

begin:vcard
fn:Jose Maria Lopez
n:Lopez;Jose Maria
org:Fagor Automation S. Coop.
adr:;;San Andres 19. Apdo. 144;Arrasate-Mondragon;;20500;Spain
email;internet:tlopez@aotek.es
title:Sotware engineer
tel;work:(34) 943719200
tel;fax:(34) 943791712 
x-mozilla-html:FALSE
url:http://www.fagorautomation.es
version:2.1
end:vcard


--------------040508050407030806050808--
