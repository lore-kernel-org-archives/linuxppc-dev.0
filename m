Return-Path: <kenneth@southpole.se>
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by ozlabs.org (Postfix) with ESMTP id 1DE42DDF36
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 22:36:26 +1000 (EST)
Received: from [127.0.0.1] (ssh.southpole.se [193.12.106.19])
	by mail.southpole.se (Postfix) with ESMTPSA id E279F4D400C
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 14:17:13 +0200 (CEST)
Subject: fastboot.
From: Kenneth Johansson <kenneth@southpole.se>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 29 May 2009 13:13:19 +0200
Message-Id: <1243595599.9769.35.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

http://www.cambridgewireless.co.uk/news/article/default.aspx?objid=36792

Anybody know what they mean by booting here. 

I have started the ads5121 board using u-boot and kernel in NOR flash
and root file system on a compact flash card connected to the IDE
interface in 2.05 second until init is started from the rootfs.

This was fast enough for what was needed I did not try to optimize
further but since I already was in the domain where changes impacted
only a few milliseconds I have a hard time imagining going down to less
than a second. 

So I guess the only way is to skip u-boot and run linux kernel directly
out of NOR. Anyone know what MontaVista is doing ?? 
