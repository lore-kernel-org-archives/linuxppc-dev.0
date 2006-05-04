Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B989E67A3D
	for <linuxppc-dev@ozlabs.org>; Fri,  5 May 2006 08:36:47 +1000 (EST)
In-Reply-To: <55C365AA-2BA4-406C-8518-616F8182FAE5@kernel.crashing.org>
References: <Pine.LNX.4.44.0605041622180.3700-100000@gate.crashing.org>
	<6B4D81B3-ECB5-4492-B3EE-16EAAEBF1405@kernel.crashing.org>
	<55C365AA-2BA4-406C-8518-616F8182FAE5@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2C632FEE-A487-44AB-ACEE-97C3000C14C4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc
Date: Fri, 5 May 2006 00:36:18 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>  void __init setup_arch(char **cmdline_p)
>>>  {
>>>  	extern void do_init_bootmem(void);
>>> +	extern void setup_panic(void);
>>
>> Can those two go into a header file please?
>
> any suggestions on which header?

The new one should just go into arch/powerpc/kernel/setup.h;
the bootmem thing could go there as well perhaps.


Segher
