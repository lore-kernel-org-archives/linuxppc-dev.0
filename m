Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49F15DDDB6
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 18:38:24 +1100 (EST)
Message-ID: <49B0D196.7080207@firmworks.com>
Date: Thu, 05 Mar 2009 21:32:38 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Li Yang-R58472 <LeoLi@freescale.com>
Subject: Re: [RFC] More compatibles or more quirk properties
References: <3A45394FD742FA419B760BB8D398F9ED29E274@zch01exm26.fsl.freescale.net>
In-Reply-To: <3A45394FD742FA419B760BB8D398F9ED29E274@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> I'm running into a dilemma choosing between two approaches of defining device tree binding.  Let's say if we have several chips with a similar SoC block, but each of them have different quirks.  If I define different compatibles for each of the chips, the driver will have a longer match table and thus bloat the device matching process.  Or we can use a same compatible for all of them and  define properties for each of the quirks.  But it somewha
Properties to describe quirks precisely are definitely better.  In fact, 
that's fundamental principle - describe the situation, don't infer a 
bunch of details from a name.
