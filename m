Return-Path: <nd@bplan-gmbh.de>
Received: from natklopstock.rzone.de (mi-ob.rzone.de [81.169.146.148])
	by ozlabs.org (Postfix) with ESMTP id 8D84B67BE5
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Oct 2006 00:49:47 +1000 (EST)
Message-ID: <4538DC0B.7060402@bplan-gmbh.de>
Date: Fri, 20 Oct 2006 16:24:11 +0200
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
References: <453771E5.4090808@bplan-gmbh.de>
	<77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>
	<453884F5.4000804@bplan-gmbh.de>
	<122A4E06-B8A6-4256-B96E-3811EA93EA25@kernel.crashing.org>
In-Reply-To: <122A4E06-B8A6-4256-B96E-3811EA93EA25@kernel.crashing.org>
Content-Type: multipart/mixed; boundary="------------030906000800000404000204"
Cc: linuxppc-dev@ozlabs.org, tnt@246tNt.com, sl@bplan-gmbh.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030906000800000404000204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kumar Gala wrote:

 >>
 >> > 4. look at replacing sram_allocator w/rheap
 >> >
 >>
 >> This SRAM allocator is the exact same from the original Linux one. In
 >> fact, it is the original one. Would it be possible to accept this code
 >> as it is and schedule rheap integration later ?
 >
 > I dont follow, what do you mean by 'original Linux one' ?

There are already some kind of Bestcomm DMA engine supoprt for some 
embbeded system (ARCH=ppc). In order to speed up the developement, the 
API is (almost) compatible so we can use the drivers wrote for this API. 
For example, the Ethernet driver enterily rely on this API. However, the 
'soon to be release' ATA driver has been rewritten.

I did not at the time (yet) to look at rheap, but I know the current 
allocator is not really good (it can not free!).

I was just thinking, as this code is alraedy in some Linux tree, we 
could still use it there, and plan to replace it by a much better one 
(keeping the API compatible) later on.

Regards,



--------------030906000800000404000204
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


--------------030906000800000404000204--
