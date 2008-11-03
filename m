Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE993DDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Nov 2008 09:53:53 +1100 (EST)
Message-ID: <490F80E1.1060909@embedded-sol.com>
Date: Tue, 04 Nov 2008 00:53:21 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Ayman El-Khashab <AymanE@tanisys.com>
Subject: Re: Accessing PCI-E resources on 460EX
References: <490F6882.6050101@embedded-sol.com>
	<16691A8B34B5D9458EA3A1C37A11555A0137F852@tanisys-ex2.Tanisys.Local>
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F852@tanisys-ex2.Tanisys.Local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ayman El-Khashab wrote:
>
> What works for me is using the mmap64 as in the following example to
> map the physical address, fd is the file descriptor for /dev/mem
>
> off64_t offset = static_cast<off64_t>(your physical address);
> void * const p =
> mmap64(0,256,PROT_WRITE|PROT_READ,MAP_SHARED,fd,offset);
>
> The only thing to note is that the address you pass should be aligned 
> to the page boundry even though some devices are not.
>   

Thanks, Ayman. I've tried that, but I'm still getting the same error.
My physical address is 0xe80000000, length is 0x100000.

Felix.
