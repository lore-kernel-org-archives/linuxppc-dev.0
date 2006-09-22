Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E48167B56
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 15:01:38 +1000 (EST)
In-Reply-To: <451282DA.2080508@freescale.com>
References: <451282DA.2080508@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <360F0BE4-6E0B-47EB-8A6C-0640F167FF82@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/11] Add support for QE and 8360EMDS board
Date: Fri, 22 Sep 2006 00:01:50 -0500
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 21, 2006, at 7:17 AM, Li Yang wrote:

> The series of patches add generic QE infrastructure called
> qe_lib, and MPC8360EMDS board support.  Qe_lib is used by
> QE device drivers such as ucc_geth driver.
>
> This version updates QE interrupt controller to use new irq
> mapping mechanism ,addresses all the comments received with
> last submission and includes some style fixes.

Wasn't there a patch for the docs that described the QE additions to  
the flat dev tree?

- k
