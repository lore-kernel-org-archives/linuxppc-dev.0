Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 47766DDE45
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 20:14:05 +1000 (EST)
In-Reply-To: <C1F9584D-E778-4BE7-B11A-5505BA9B6F6C@freescale.com>
References: <20070604095625.GF17456@chiana.homelinux.org>
	<4E25DA41-741E-40AC-9186-936FEEFE6B29@freescale.com>
	<20070604211740.GN17456@chiana.homelinux.org>
	<C1F9584D-E778-4BE7-B11A-5505BA9B6F6C@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cbf493edec7259df199568389814dab6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 83xx GPIO/EXT int in arch/powerpc/
Date: Tue, 5 Jun 2007 12:13:57 +0200
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> You can't use hard-coded numbers
> anymore.  You need to map them into virtual numbers.  The easiest way
> is to set up an of node for the device, and invoke the necessary
> translation functions from your board code

As long as the interrupt graph in your device tree is
correct, all this should work just like magic ;-)


Segher
