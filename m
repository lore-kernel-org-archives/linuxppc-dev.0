Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7FF2ADDEB6
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 22:15:28 +1100 (EST)
Message-ID: <474AAAB4.7000104@scram.de>
Date: Mon, 26 Nov 2007 12:15:00 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH revised 3/4] powerpc: Add EXPORT_SYMBOL_GPL for symbols
	required by fs_enet and cpm_uart
References: <4745BDC9.3080602@scram.de>	<47499711.2020409@freescale.com>
	<20071125191833.1e76f335@kernel.crashing.org>
In-Reply-To: <20071125191833.1e76f335@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

>> Maybe this is a stupid question, but why did you choose
>> EXPORT_SYMBOL_GPL and not EXPORT_SYMBOL?
>>
> To prevent using those pointers from within non-GPL modules. kind of policy now...

In particular in this case, as these pointers are currently not exported, at all. They
are currently used by a few drivers and will disappear again once these drivers have
been converted to use the propper accessors, which will also prevent access conflicts
to the CPM registers.

Thanks,
Jochen
