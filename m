Return-Path: <nd@bplan-gmbh.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id 943F767C03
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 20:09:01 +1100 (EST)
Date: Tue, 31 Oct 2006 10:08:55 +0100 (MET)
Message-ID: <454712A4.3000501@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller
	support	for	ARCH=powerpc
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>	
	<7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>	
	<4546F7DE.6070104@bplan-gmbh.de>	
	<1162280335.25682.302.camel@localhost.localdomain>	
	<4547086D.2050808@bplan-gmbh.de>
	<1162284176.25682.320.camel@localhost.localdomain>
In-Reply-To: <1162284176.25682.320.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------030802070209050503080306"
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030802070209050503080306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> On Tue, 2006-10-31 at 09:25 +0100, Nicolas DET wrote:
> 
>> Ok. By the way, the mbar is include as property in our OpenFrimware. 
>> Moreover, the G2CORE CPU has a new SPR 'MBAR' which is the MBAR ;-). It 
>> would maybe make sense to create a new file 
>> (arch/powerpc/sysdev/mpc52xx.c) which would contain chip specific code.
>>
>> Like mpc52xx_get_mbar(), mpc52xx_get_ipbfreq(), etc...
>>
>> I updated a bit the patches. I applied Dale requests.
>> My kernel still compiles and boots. ;-)
>>
>> Should I post the new patches?
> 
> Sure.
> 

Ok. Should be done this morning.

>> About the headers thingy. Should I split them directly in the patch, or 
>> this should be done by others later on?
> 
> Don't bother that much about splitting the headers. I personally don't
> mind.
> 

Ok. so I keep everything in include/asm-powerpc/mpc52xx.h for now.

>> About the serials and USB part. Have anyone already do some work (moving 
>> to of_platform, etc...)?
> 
> I think Grant has.
> 

Ok.

>> As far as I see, the Efika platform patch did not get any comment, 
>> should I assume it is good enough for inclusion in the main stream kernel?
> 
> It looked ok at a very very quick glance. I'll give a better look.
> 

Ok.

Regards,

--------------030802070209050503080306
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


--------------030802070209050503080306--
