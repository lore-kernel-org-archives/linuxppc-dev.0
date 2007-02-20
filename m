Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A5C27DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 02:32:09 +1100 (EST)
Message-ID: <45DB146A.7010302@cambridgebroadband.com>
Date: Tue, 20 Feb 2007 15:31:54 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Manjunath AM <Manjunath.AM@Lntemsys.com>, linuxppc-embedded@ozlabs.org
Subject: Re: enabling two eths
References: <OFAEAB5385.D1B18D5F-ON65257288.0048394A-65257288.00493E72@lntemsys.com>
In-Reply-To: <OFAEAB5385.D1B18D5F-ON65257288.0048394A-65257288.00493E72@lntemsys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Manjunath AM wrote:
> 
> Hi,
> 
> We are using MPC8272 based target board, we use montavista Linux version 
> 2.6.10 kernel image (with NFS enabled) to our target board,
> 
> Our board has  2 FCCs (eth0 and eth1). bot the eth's works perfectly 
> when we use them independently, but when we are trying to enable second 
> one after the kernel is up using linux command  "ifconfig eth1 
> 192.168.33.64 up"(IP address)nothing is working.
> Please suggest how to enable second eth (either 0 or 1) once the kernel 
> is up with NFS file system


Have you made sure that eth0 and eth1 are on *different* IP subnets?
If they are on the same subnet, or intersecting subnets, your routing
will get confused.
