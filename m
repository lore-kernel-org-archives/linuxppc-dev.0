Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2CFCDDF7E
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 23:22:36 +1100 (EST)
In-Reply-To: <45A74E2F.2000901@246tNt.com>
References: <20070111122855.GF11226@localhost.localdomain>	<37B2A6BB-4F36-4765-A1C2-A4F8D30D4503@kernel.crashing.org>	<20070111152137.GG11226@localhost.localdomain>	<17831.627.162751.166002@cargo.ozlabs.ibm.com>
	<20070112084612.GJ11226@localhost.localdomain>
	<45A74E2F.2000901@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5b4c7248d9ed3c7a6fc4fe6ecf4ad7f9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] add restart function for mpc52xx
Date: Fri, 12 Jan 2007 13:23:11 +0100
To: Sylvain Munaut <tnt@246tNt.com>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'm not saying the system is perfect but this issue is more related to
> recent
> bindings that the of thing as a whole. That's more the problem with of
> is that
> when you need to define bindings for something that has none, you may 
> not
> anticipate everything ....

... which is why it is so important that you don't "define"
"bindings" "in-house".  (Sorry for all those quotes ;-) )


Segher
