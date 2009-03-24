Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 04790DDF61
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 00:15:28 +1100 (EST)
Message-Id: <382F4B5D-93C4-41BB-A00A-8A6C240CD170@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Andy Fleming <afleming@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: make sure ucc_geth.c fixed-link support still works in net-next
Date: Tue, 24 Mar 2009 08:15:13 -0500
Cc: LinuxPPC Mailing List <linuxppc-dev@ozlabs.org>,
	Joakim Tjernlund <Joakim.Tjernlund@transmode.se>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton, Andy

Can you take a look at the recent net-next tree and make sure that the  
merge between the fsl_pq_mdio.c support and the patch that went into  
2.6.29 to fix fixed-link support in ucc_geth.c is correct and still  
works.

See commits:
	Merge branch master... (8be7cdccacfbfc707e7370cad9bb168defed636f)
	ucc_geth: Fix merge error. (039a6f6a39d2aa30ee53afdb213ea6dd4482928b)

- k
