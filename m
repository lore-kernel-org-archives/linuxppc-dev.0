Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6BEB0DE14D
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 00:26:16 +1000 (EST)
Message-Id: <C7C29031-E717-4D83-874A-DC0D1E12BA3D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Stephen Hemminger <shemminger@vyatta.com>,
	David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: converting fs_enet to net_device_ops
Date: Thu, 9 Apr 2009 09:26:08 -0500
Cc: netdev@vger.kernel.org, Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Can someone look at converting drivers/net/fs_enet over to the new  
net_device_ops.

Dave,

Are you willing to take such a patch in for .30?  Otherwise we need to  
add a select COMPAT_NET_DEV_OPS in Kconfig for this driver (and any  
others that might not have been converted over).  drivers/net/ 
ibm_newemac/ is another.

- k
