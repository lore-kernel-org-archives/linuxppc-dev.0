Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 22334DDE4A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 21:35:50 +1100 (EST)
Date: Wed, 24 Jan 2007 02:35:48 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Laurent Pinchart <laurent.pinchart@technotrade.biz>
Subject: Re: JTAG emulator for MPC8548E (v2)
Message-ID: <20070124103548.GA31703@gate.ebshome.net>
References: <BD261180E6D35F4D9D32F3E44FD3D901062D1E42@EMPBEDEX.empirix.com>
	<528646bc0701230956v26e34c5bx7d3fc082fe1d20c9@mail.gmail.com>
	<BD261180E6D35F4D9D32F3E44FD3D901062D1F17@EMPBEDEX.empirix.com>
	<200701240857.19428.laurent.pinchart@technotrade.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200701240857.19428.laurent.pinchart@technotrade.biz>
Cc: "Morrison, Tom" <tmorrison@empirix.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 24, 2007 at 08:57:19AM +0100, Laurent Pinchart wrote:
> The new unit works *mostly* fine. No debugging issue (not that I use it that 
> much anyway, now that the board boots Linux), but still a flash programming 
> issue. Programming the target parallel NOR flash works in slow JTAG mode, but 
> not in faster mode using the internal workspace. I reported the problem 
> several months ago and still haven't received any solution.

Most likely problem isn't in BDI but in your setup. Depending on 
the particular chip model, to be able use workspace you must have 
initialized memory first. In fact, I'm pretty sure you haven't 
configured chip correctly to make workspace usable. I've been using 
BDI with various PowerPC and MIPS SoCs for many years. It's an excellent 
tool, you just have to use it correctly.

-- 
Eugene
