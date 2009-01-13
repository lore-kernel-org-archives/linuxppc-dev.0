Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 606BFDE172
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 08:22:40 +1100 (EST)
Message-Id: <DCE9B8B2-733D-49A4-B8E7-AA6D79D0CDE9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <EB245BEE-52C5-40DD-A9DD-A106A5937219@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Please pull from 'next' branch (2.6.29)
Date: Tue, 13 Jan 2009 15:22:35 -0600
References: <Pine.LNX.4.64.0901130917190.21289@blarg.am.freescale.net>
	<1231880384.22571.46.camel@pasglop>
	<EB245BEE-52C5-40DD-A9DD-A106A5937219@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 13, 2009, at 3:17 PM, Kumar Gala wrote:

>>>
>>>     powerpc/83xx: Move mcu_mpc8349emitx driver out of drivers/i2c/ 
>>> chips/
>
> At Jean's request to move i2c clients out of drivers/i2c.

Getting this into .29 might be useful since its just a driver move and  
saves us merge headache's later.

- k
