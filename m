Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41A05681B8
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 02:10:49 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1651B3F8-87C2-4A6E-8D66-BF24B3AB83D9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Lost patches in powerpc.git
Date: Tue, 7 Feb 2006 09:10:44 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

It appears in your last merge of patches into powerpc.git you lost  
some patches.  This is my best attempt at listing out the patches you  
lost:

     [PATCH] PPC32 8xx: support for the physmapped flash on m8xx
     [PATCH] powerpc: generalize PPC44x_PIN_SIZE
     [PATCH] powerpc: Add CONFIG_DEFAULT_UIMAGE to build a uImage by  
default for a board
     [PATCH] ppc32 8xx: Added setbitsXX/clrbitsXX macro for read- 
modify-write operations
     [PATCH] powerpc: Updated Initial MPC8540 ADS port with OF Flat Dev

- kumar
