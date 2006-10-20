Return-Path: <nd@bplan-gmbh.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 3EE8B67B9B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 18:14:53 +1000 (EST)
Message-ID: <453884F5.4000804@bplan-gmbh.de>
Date: Fri, 20 Oct 2006 10:12:37 +0200
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
References: <453771E5.4090808@bplan-gmbh.de>
	<77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>
In-Reply-To: <77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>
Content-Type: multipart/mixed; boundary="------------060206050701080407040008"
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
--------------060206050701080407040008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kumar Gala wrote:
 >
 > On Oct 19, 2006, at 7:39 AM, Nicolas DET wrote:
 >
 >> This 'big' patch adds support for CHRP/MPC52xx based platform. Here, 
this is the bPlan's Efika computer 
(http://www.bplan-gmbh.de/efika_spec_en.html)
 >

 > Some high level comments:
 > 1. lets stick with the 52xx naming, instead of 5k2

Ok. Will be done

 > 2. PIC code needs to be updated for new interrupt model (as well as 
remove of pt_regs)

Ok.

 > 3. use standard kernel debug macros

Loads of changes in the pipe line ;-)

 > 4. look at replacing sram_allocator w/rheap
 >

This SRAM allocator is the exact same from the original Linux one. In 
fact, it is the original one. Would it be possible to accept this code 
as it is and schedule rheap integration later ?

 > if you repost the patch broken up into driver and platform bits it 
will be easier to provide more detailed comments.

Ok. I'm alraedy working on it since I post the first one :-) . Thank you 
very much for your comments. I hope to re submit a much better patch today.

Regads

--------------060206050701080407040008
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


--------------060206050701080407040008--
