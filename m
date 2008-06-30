Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83A88DE0BE
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 06:57:13 +1000 (EST)
In-Reply-To: <D70C5CB6-5066-4AD3-9367-879AF39FB8E1@kernel.crashing.org>
References: <Pine.LNX.4.64.0806271449540.9071@blarg.am.freescale.net>
	<48654D6D.1090309@freescale.com>
	<E57F448A-7217-4893-A77B-6367B0C3118A@kernel.crashing.org>
	<Pine.LNX.4.64.0806271609540.10625@blarg.am.freescale.net>
	<20080630041525.GD24012@yookeroo.seuss>
	<20080630153513.GD13950@loki.buserror.net>
	<D70C5CB6-5066-4AD3-9367-879AF39FB8E1@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9feed9d3c12e4b7fdd28262fd431206e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: Add dma nodes to 83xx, 85xx and 86xx boards
Date: Mon, 30 Jun 2008 22:56:51 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> What's the cell-index in these nodes used to index?  Given the
>>> confusion there's been about the proper use of this property, a
>>> comment indicating which shared registers this is used to index is
>>> probably a good idea.
>>
>> There's supposed to be a cell-index in the *channels* to index into 
>> the
>> shared summary register (the "reg" of the dma node itself).  I don't 
>> see any
>> purpose for a cell-index in the main dma node, though.
>
> I believe this comes into play when we have more than one DMA 
> controller and sometimes there are special uses like on 8610.

There is no need to guess what it is or isn't used for.  Just look
it up in the binding for this device.


Segher
