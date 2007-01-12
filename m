Return-Path: <tnt@246tNt.com>
Received: from outmx024.isp.belgacom.be (outmx024.isp.belgacom.be
	[195.238.4.128])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 92D8EDE190
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 23:41:56 +1100 (EST)
Received: from outmx024.isp.belgacom.be (localhost [127.0.0.1])
	by outmx024.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l0CCfaY4021220
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 13:41:41 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45A7817B.2040504@246tNt.com>
Date: Fri, 12 Jan 2007 13:39:23 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] add restart function for mpc52xx
References: <20070111122855.GF11226@localhost.localdomain>	<37B2A6BB-4F36-4765-A1C2-A4F8D30D4503@kernel.crashing.org>	<20070111152137.GG11226@localhost.localdomain>	<17831.627.162751.166002@cargo.ozlabs.ibm.com>
	<20070112084612.GJ11226@localhost.localdomain>
	<45A74E2F.2000901@246tNt.com>
	<5b4c7248d9ed3c7a6fc4fe6ecf4ad7f9@kernel.crashing.org>
In-Reply-To: <5b4c7248d9ed3c7a6fc4fe6ecf4ad7f9@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
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

Segher Boessenkool wrote:
>> I'm not saying the system is perfect but this issue is more related to
>> recent
>> bindings that the of thing as a whole. That's more the problem with of
>> is that
>> when you need to define bindings for something that has none, you may
>> not
>> anticipate everything ....
>
> ... which is why it is so important that you don't "define"
> "bindings" "in-house".  (Sorry for all those quotes ;-) )
>
Well, those were posted on the ml for everyone to read ;)


    Sylvain
