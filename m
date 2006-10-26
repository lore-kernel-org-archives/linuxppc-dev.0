Return-Path: <nd@bplan-gmbh.de>
Received: from mo-p04-ob.rzone.de (mo-p04-ob.rzone.de [81.169.146.177])
	by ozlabs.org (Postfix) with ESMTP id 3135D67CB3
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 21:09:53 +1000 (EST)
Date: Thu, 26 Oct 2006 13:09:41 +0200 (MEST)
Message-ID: <454096E5.8050202@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
References: <453FB582.20802@bplan-gmbh.de>	
	<17727.56923.634981.723647@cargo.ozlabs.ibm.com>	
	<528646bc0610251541s21bb45f1t6fc911778d5084@mail.gmail.com>
	<1161817178.22582.138.camel@localhost.localdomain>
In-Reply-To: <1161817178.22582.138.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------090601000803030007070004"
Cc: akpm@osdl.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org,
	sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090601000803030007070004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:

>  - Format of the interrupt cells (they have come up upon my suggestion
> to a 3-cell based format (could probably be compressed a bit but heh)
> and that should be documented publically)
> 

It's some kind of 'documented' in mpc52xx_pic.c/xlate()

>  - Binding (set of required properties and their definitions) for on
> chip devices, and more specifically, for representing the bestcomm and
> the links between devices and associated bestcomm tasks.

Bestcomm is something a bit 'weird'. I think we are the only to use this 
approach (task code loaded by the OFW and not by the OS). As said 
earlier, I've been in contact with an bestcomm coders and I think we 
would work together on this subject.


--------------090601000803030007070004
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


--------------090601000803030007070004--
