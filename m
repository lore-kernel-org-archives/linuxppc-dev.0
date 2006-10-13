Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9CF267C32
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Oct 2006 01:34:02 +1000 (EST)
In-Reply-To: <3C02138692C13C4BB675FE7EA24095291F5A08@bluefin.Soneticom.local>
References: <3C02138692C13C4BB675FE7EA24095291F5A08@bluefin.Soneticom.local>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EE6BAB8C-DD74-412B-BDD1-1758426B62F7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: GCC version to kernel version
Date: Fri, 13 Oct 2006 10:34:09 -0500
To: Clint Thomas <cthomas@Soneticom.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 13, 2006, at 9:55 AM, Clint Thomas wrote:

> Hey guys,
>
> Generic question here. To each linux kernel version, is there a  
> specific version of GCC and GLIBC I should be using to build the  
> kernel, RFS, etc? I cannot seem to find any concrete proof that  
> this is the case, but I am having issues building a new RFS with my  
> older GCC and GLIBC, so I'm looking at updating them. I'm currently  
> using GCC 3.3.2 and GLIBC 2.3.2 to build for the Linux 2.4.27  
> kernel on an e500 (MPC8541) core. Thanks!
>

It depends on what user space functionality you want/need form e500.   
If you plan on using SPE or fp I'd say to make sure to get tools  
chains that support e500.  If you are just running normal integer  
code than any toolchain should be fine.

- k
