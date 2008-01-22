Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B951FDE2A0
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 08:07:51 +1100 (EST)
Message-Id: <65C80AAA-CC92-41BC-86FC-D74A2C7D5059@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <47965506.9070305@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v2 1/2] Add localbus and flash nodes to mpc8641_hpcn.dts
Date: Tue, 22 Jan 2008 15:07:16 -0600
References: <1201019917.5716.154.camel@rhino> <1201032819.5716.170.camel@rhino>
	<47965506.9070305@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 22, 2008, at 2:41 PM, Jon Loeliger wrote:

> Wade Farnsworth wrote:
>
>> +
>> +		ranges = <0 0 ff800000 00800000
>> +			  1 0 fe000000 01000000
>> +			  2 0 f8200000 00100000
>> +			  3 0 f8100000 00100000>;
>> +
>
> I think you want just:
>
>   ranges = <0 0 f8000000 8000000>
>
> right?  And is it really on CS 0?

I'm assuming he's listed CS1, CS2, and CS3 even though we don't have a  
children yet.  (second flash chip, CF, and pixis).

- k
