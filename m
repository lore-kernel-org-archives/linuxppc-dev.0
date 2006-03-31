Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84A83679E0
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 01:39:17 +1100 (EST)
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467305790AEB@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467305790AEB@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2DAA97AA-4DB6-4E2B-A702-729681BCA478@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: moving board support from arch/ppc/ to arch/powerpc
Date: Fri, 31 Mar 2006 08:39:20 -0600
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 31, 2006, at 4:44 AM, Zang Roy-r61911 wrote:

> Hi,
> 	I am moving mpc7448 hpc2 support from arch/ppc to arch/powerpc and  
> plan to summit it to open source tree future.  Is there any good  
> suggestion or reference?
> 	Thanks a lot!

All ports under arch/powerpc are required to use a flat device tree  
to boot.  Look at Documentation/powerpc/booting-without-of.txt
  for details on how that is done.  Beyond that there isn't too much  
different from arch/ppc to arch/powerpc.  Take a look at the 83xx or  
85xx platforms for comparison examples between arch/ppc & arch/powerpc.

I'd suggest for working up your flat dev tree for the bridge on HPC2  
and post that to the linuxppc-dev list for review and then go from  
there.

- kumar
