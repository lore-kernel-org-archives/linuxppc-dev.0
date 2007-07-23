Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 080CBDDEC6
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 01:47:26 +1000 (EST)
Message-ID: <46A4CD7B.7070001@freescale.com>
Date: Mon, 23 Jul 2007 10:47:07 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Someone broke my allmodconfig build
References: <20070722001212.5007001d.sfr@canb.auug.org.au>	
	<18082.42674.651685.720737@cargo.ozlabs.ibm.com>	
	<20070722115354.0c28d704.sfr@canb.auug.org.au>	
	<46A4A9DC.6010602@freescale.com>
	<fa686aa40707230807k450ff82dv11201ca3a4ce4c9b@mail.gmail.com>
In-Reply-To: <fa686aa40707230807k450ff82dv11201ca3a4ce4c9b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 7/23/07, Timur Tabi <timur@freescale.com> wrote:
>> Stephen Rothwell wrote:
>>
>> >> Hmmm, we should be shipping .dtb files with the tree, so people don't
>> >> have to have dtc installed.
>> >
>> > Unless, of course, we ship dtc ...
>>
>> I like that idea.
>>
>> I don't know much about the kernel build process, but is it normal to 
>> ship C files and have kbuild build them and then use the executables 
>> to build the rest of the kernel?
> 
> That's how Kconfig is built.

Then it shouldn't be too hard to refactor the dtc build environment to make it 
Kbuild-compatible, and then Paul can pull from Jon's dtc repo whenever it gets updated.

Jon, what do you think?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
