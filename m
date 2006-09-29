Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E794967BC6
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 00:15:03 +1000 (EST)
In-Reply-To: <451CF6C0.7040701@freescale.com>
References: <451CF6C0.7040701@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <65774A0C-1AD2-4E72-9D89-ACC77BE9CEB4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/9] Add support for QE and 8360EMDS board -v3
Date: Fri, 29 Sep 2006 09:15:34 -0500
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 29, 2006, at 5:34 AM, Li Yang wrote:

> Paul,
>
> The series of patches add generic QE infrastructure called
> qe_lib, and MPC8360EMDS board support.  Qe_lib is used by
> QE device drivers such as ucc_geth driver.
>
> This version updates QE interrupt controller to use new irq
> mapping mechanism, addresses all the comments received with
> last submission and includes some style fixes.
>
> v2: Change to use device tree for BCSR and MURAM;
> Remove I/O port interrupt handling code as it is not generic
> enough.
>
> v3: Address comments from Kumar;  Update definition of several
> device tree nodes;  Copyright style change.

In going through this code some general comments:
* remove typedef's, its not the normal convention to use typedefs the  
way this code is.  Makes it more difficult to read
* look at use of uint vs u32.  I think there are a number of cases  
were you really want u32.

Also, can you provide some high level description of what all this  
code is doing.  I understand the port io init, I get the interrupt  
handling.  I'm at a loss as that what all the channel ucc_fast/ 
ucc_slow code is trying to do and some of the init code.

- k
