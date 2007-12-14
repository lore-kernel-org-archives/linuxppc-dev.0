Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B5B8DDFE5
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 19:08:22 +1100 (EST)
Message-Id: <77815911-B0FA-4FFD-AC50-5C9A8FED90C4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071214081210.GB27284@lixom.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] Emulate isel (Integer Select) instruction
Date: Fri, 14 Dec 2007 02:08:14 -0600
References: <Pine.LNX.4.64.0711192135460.24923@blarg.am.freescale.net>
	<20071120175416.GA4389@loki.buserror.net>
	<B82E6C31-8BB7-4348-9426-B18A971172A9@kernel.crashing.org>
	<Pine.LNX.4.62.0711211407260.12720@pademelon.sonytel.be>
	<Pine.LNX.4.62.0711271555520.5847@pademelon.sonytel.be>
	<20071127152317.GA5230@lixom.net>
	<Pine.LNX.4.62.0711281148020.27512@pademelon.sonytel.be>
	<Pine.LNX.4.62.0711291612290.24058@pademelon.sonytel.be>
	<20071214081210.GB27284@lixom.net>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 14, 2007, at 2:12 AM, Olof Johansson wrote:

> On Thu, Nov 29, 2007 at 04:13:14PM +0100, Geert Uytterhoeven wrote:
>> On Wed, 28 Nov 2007, Geert Uytterhoeven wrote:
>>> +static inline void warn_emulated_sysctl_register(void)
>>> +{
>>> +	int res = register_sysctl_table(warn_emulated_sysctl_root);
>>        ^^^^^^^^^^
>>> +	printk("@@@ register_sysctl_table() returned %d\n", res);
>>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> +}
>>
>> Woops, that part shouldn't have been there...
>
> Care to resubmit a clean patch under a fresh subject? Paul didn't  
> chime
> in but hopefully he can pick it up for 2.6.25.

I'd say wait for Paul to pickup my 2.6.25 request.  Than the base will  
have the isel emulation as well.

- k
