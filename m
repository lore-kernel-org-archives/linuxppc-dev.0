Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B531467C0F
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 02:58:33 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <724D42AC-3DBA-4B32-8E4A-914441251470@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: RFC: qe lib code location?
Date: Tue, 3 Oct 2006 11:34:11 -0500
To: Kim Phillips <Kim.Phillips@freescale.com>,
 Li Yang <leoli@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I was wondering what peoples thought were on having the qe lib code  
live in drivers/qe instead of sysdev/qe_lib (with the exception of  
the interrupt controller code)

Yes, one can argue the cpm code should live in drivers/cpm by this  
logic, but lets considered them grandfathered for now.

- kumar
