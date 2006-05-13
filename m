Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AEE13679F6
	for <linuxppc-dev@ozlabs.org>; Sun, 14 May 2006 09:44:47 +1000 (EST)
Subject: Re: Load average 1.0 on idle machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Juergen Kreileder <jk@blackdown.de>
In-Reply-To: <87wtcplejw.fsf@blackdown.de>
References: <87wtcplejw.fsf@blackdown.de>
Content-Type: text/plain
Date: Sun, 14 May 2006 09:44:33 +1000
Message-Id: <1147563873.21291.13.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-05-14 at 00:56 +0200, Juergen Kreileder wrote:
> Hi,
> 
> with both 2.6.16.11 and 2.6.17-rc4 my PowerMac G5 Quad shows a load
> average of 1.0 when the machine is completely idle (just kernel, init,
> and bash running).

Must be a kernel thread blocking with TASK_UNINTERRUPTIBLE... maybe the
thermal code, I'll have to check.

Ben.
