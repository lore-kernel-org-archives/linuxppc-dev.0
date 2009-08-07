Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4A552B7BB7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 12:44:39 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6548DDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 12:44:38 +1000 (EST)
Message-Id: <A67874B9-1BEE-4F11-99CF-546F01A9BC8D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20090630143226.10778.29002.stgit@ES-J7S4D2J.amer.consind.ge.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH] powerpc/86xx: Correct reading of information presented in
	cpuinfo
Date: Thu, 6 Aug 2009 21:44:29 -0500
References: <20090630143226.10778.29002.stgit@ES-J7S4D2J.amer.consind.ge.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 30, 2009, at 9:32 AM, Martyn Welch wrote:

> /proc/cpuinfo should be showing the boards revision and the revision  
> of the FPGA fitted. The functions currently used to access this  
> information as incorrect.
>
> Additionally the VME geographical address of the PPC9A and it's  
> status as system contoller are available in the board registers.  
> Show these in cpuinfo.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/platforms/86xx/gef_ppc9a.c |   37 ++++++++++++++++++++++ 
> +++------
> 1 files changed, 30 insertions(+), 7 deletions(-)


applied to next.

(Fixed the comment formatting to wrap properly)

- k
