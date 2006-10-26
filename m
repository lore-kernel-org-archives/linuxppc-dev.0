Return-Path: <nd@bplan-gmbh.de>
Received: from mo-p04-ob.rzone.de (mo-p04-ob.rzone.de [81.169.146.178])
	by ozlabs.org (Postfix) with ESMTP id 3AD6B67DBE
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 22:09:39 +1000 (EST)
Date: Thu, 26 Oct 2006 14:09:35 +0200 (MEST)
Message-ID: <4540A4EF.5030802@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
References: <453FB582.20802@bplan-gmbh.de>	
	<528646bc0610251601l171eb05k73e1af1c3391ae8@mail.gmail.com>
	<1161817576.22582.142.camel@localhost.localdomain>
In-Reply-To: <1161817576.22582.142.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------050905030907010201070204"
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
--------------050905030907010201070204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:

>>> * serial stuff / IBP Freq. As this frequency is MPC52xx specific. I
>>> think it would make sense to add a new func mpc52xx_getipbfreq(void).
>>> The way it would be implemented may depend of the architecture. Our
>>> firmware contains an 'ipb-freq' property in '/builtin/'.
> 
> BTW. I forgot to comment on the above in my previous mail... As I said,
> there should be no such thing. Instead, the IPB freq should be in the
> device-tree.
> 
> 
> 

What do you mean exactly by 'the IPB freq should be in the device-tree'? 
It is as property.

Regards

--------------050905030907010201070204
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


--------------050905030907010201070204--
