Return-Path: <dan@embeddedalley.com>
Received: from smtp100.biz.mail.re2.yahoo.com (smtp100.biz.mail.re2.yahoo.com
	[206.190.52.46]) by ozlabs.org (Postfix) with SMTP id A822CDDE0E
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 08:10:35 +1100 (EST)
In-Reply-To: <20071125191833.1e76f335@kernel.crashing.org>
References: <4745BDC9.3080602@scram.de> <47499711.2020409@freescale.com>
	<20071125191833.1e76f335@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <19DACFA1-05DB-4331-BE71-282590B9DFE5@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH revised 3/4] powerpc: Add EXPORT_SYMBOL_GPL for symbols
	required by fs_enet and cpm_uart
Date: Sun, 25 Nov 2007 13:02:03 -0800
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 25, 2007, at 8:18 AM, Vitaly Bordug wrote:

> To prevent using those pointers from within non-GPL modules. kind  
> of policy now...

As the original copyright holder of nearly all of this of
this code, I do not wish this be done.

Thanks.

	-- Dan
