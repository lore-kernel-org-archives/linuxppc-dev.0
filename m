Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C5F98DDF69
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 20:44:40 +1000 (EST)
In-Reply-To: <46725D02.9090806@ru.mvista.com>
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
	<467176EB.7060404@ru.mvista.com>
	<20070614222620.GA17382@mag.az.mvista.com>
	<c6cd3a9fe7713f081354cca9b4306811@kernel.crashing.org>
	<46725411.3080002@ru.mvista.com>
	<a849b0caedb72f3799c095d3ab6cebd1@kernel.crashing.org>
	<46725D02.9090806@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <63193b592eea9422036fc63f0899bb7b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
Date: Fri, 15 Jun 2007 12:44:32 +0200
To: "Vladislav D. Buzov" <vbuzov@ru.mvista.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Do fix the comment though ;-)
> Once somebody tests the patch on other 7450 processors I'll remove the 
> comment and send a new patch. Is it ok? Or I should create a new patch 
> first?

No, this is perfectly fine.  Thanks!


Segher
