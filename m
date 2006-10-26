Return-Path: <nd@bplan-gmbh.de>
Message-ID: <4540EEF4.80201@bplan-gmbh.de>
Date: Thu, 26 Oct 2006 19:23:00 +0200
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: John Rigby <jcrigby@gmail.com>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
References: <453FB582.20802@bplan-gmbh.de>
	<4b73d43f0610261017s38cdc78fn23ea07113bf8c0fc@mail.gmail.com>
In-Reply-To: <4b73d43f0610261017s38cdc78fn23ea07113bf8c0fc@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------040404050709020605070807"
Cc: akpm@osdl.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040404050709020605070807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

John Rigby wrote:
>>
>> * mpc5k2_bestcomm.c (& helpers): I've been in contact with others people
>> using bestcomm and please to see the development was still active. I'm
>> already using latest code on my board but this is not include in this
>> patch. Indeed, it needs some changes for ARCH=powerpc. Moreover, we have
>> a different approach for the tasks. I'll be pleased to work with the
>> bestcomm folks.
>>
> 
> So you preload the bestcomm task code in your boot loader?  

Yes.

>Do those
> of us using other bootloaders still have the option of loading the
> task code later in linux?

Well, just reading the phy address from 0xf008000 to 0xf00c0000 (if I 
remenber correctly) should be enough to get the tasks code.

> What api are you using?  Sylvain's proposed one based on Dale's with
> some additions from me?  Or have you come up with your own?
> 

We implemented our own yet. However, we could moved to any.

Regards,

--------------040404050709020605070807
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------040404050709020605070807--
