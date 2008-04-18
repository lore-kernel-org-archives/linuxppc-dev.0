Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D558DE232
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 23:20:57 +1000 (EST)
Message-Id: <9CE9EFA8-A303-49C9-B9A2-F62D42F927B7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18440.34891.440661.248400@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Patches added to powerpc.git master and powerpc-next branches
Date: Fri, 18 Apr 2008 08:20:52 -0500
References: <18440.34891.440661.248400@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 18, 2008, at 6:38 AM, Paul Mackerras wrote:
> I have pushed out the following commits to the master and powerpc-next
> branches of the powerpc.git tree.  This includes commits from Kumar's
> and Jeremy's trees.
>
> I am intending to ask Linus to pull the powerpc-next branch once we
> have the breakage from the OF helpers for i2c patch sorted out.
>
> Paul.

What are we doing with these two patches:

[POWERPC] 85xx: Add support for relocatble kernel (and booting at non- 
zero)
[POWERPC] Port fixmap from x86 and use for kmap_atomic

I know the second was late, but I'd like us to think about putting it  
in for v2.6.26.  It gives us a good basis for the PCIe 44x and 83xx  
config cycle work and kexec/kdump work for v2.6.27.

thanks.

- k
