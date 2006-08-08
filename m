Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DABA867B56
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Aug 2006 23:04:52 +1000 (EST)
In-Reply-To: <000001c6babc$0e795b10$8500a8c0@dc.roysiu.servebbs.com>
References: <000001c6babc$0e795b10$8500a8c0@dc.roysiu.servebbs.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7E5B86C0-2569-4CFA-9900-E5CE195EB370@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: crosslink build script --- can't find any option for 8241 PPC,
	what option ought to be choosed
Date: Tue, 8 Aug 2006 08:04:48 -0500
To: alva <vows_siu@yahoo.com.hk>
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


On Aug 8, 2006, at 2:26 AM, alva wrote:

> Dear friends,
>
> I recently bought a Synology Network Attached Server DS-106e, run  
> using a "Linux 2. 4.22-uc-0" Kernel, under 8041 PPC, no "gcc"  
> installed. I want to build a crosslink gcc compiler for it in  
> another "debian 2.6 kernel" linux. I find many options in the  
> crosslink build script on ppc, but can't find any option for 8041  
> PPC. So what option should I choose? And further can I put the  
> artifacts just compiled in my Network Attached Server? So that I  
> can compile anything directly in my NAS.
>

I assume you mean 8241 like the subject says since there is no 8041  
PPC.  If so you want an 603 toolchain.

- k
