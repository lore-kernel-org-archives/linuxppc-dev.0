Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx026.isp.belgacom.be (outmx026.isp.belgacom.be
	[195.238.4.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79A25679FC
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Jun 2006 00:09:19 +1000 (EST)
Received: from outmx026.isp.belgacom.be (localhost [127.0.0.1])
	by outmx026.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k57E9AiS010511
	for <linuxppc-embedded@ozlabs.org>; Wed, 7 Jun 2006 16:09:10 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: *** PROBABLY SPAM *** Re: CPM_UART should allocate DPRAM for SMCx
	parameter RAM on MPC82xx
Date: Wed, 7 Jun 2006 16:10:51 +0200
References: <200606071434.08905.laurent.pinchart@tbox.biz>
	<200606071539.57394.laurent.pinchart@tbox.biz>
	<20060607174931.766eda5d@vitb.ru.mvista.com>
In-Reply-To: <20060607174931.766eda5d@vitb.ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606071610.51465.laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> As I said, SMC offsets relative to pram things are screwed for PQ2.
> That needs to be fixed. It is assumed, that for each SMC ready-for-use
> offset should be defined in pram resource (as for 8xx). There is no need to
> dpalloc/dpfree because the idea is that pram thing should be fixed to
> prevent confusion. So the odd offset for SMC devices in pq2_devices.c
> should be replaced with correct values (which should be
> dpram_start+PROFF_SMCx - have a look at 8xx as reference)

Ok. dpram[PROFF_SMCx_BASE] must still be set to the values returned by 
platform_get_resource_byname(). Where should that be done ?

Laurent Pinchart
