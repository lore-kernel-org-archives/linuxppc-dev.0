Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id E537A679E0
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2006 23:35:00 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Problems of Compiling Kernel with linux-2.4.27 and linux-2.6.17
	for PowerPC405EP Board
Date: Wed, 12 Jul 2006 15:15:06 +0200
References: <20060712130102.40670.qmail@web15604.mail.cnb.yahoo.com>
In-Reply-To: <20060712130102.40670.qmail@web15604.mail.cnb.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200607121515.07088.g.jaeger@sysgo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 12 July 2006 15:01, Zhou Rui wrote:
> Hi,
> Yesterday I tried to compile kernel with linux-2.4.27 and linux-2.6.17 for PowerPC405EP board. Both of the kernel images were created successfully, but when I tested them in ram from u-boot with NFS used. Both of the images could not booted from ram. The two kernel .config files are attached.
> 
> For the 2.4.27 kernel, after running bootm in u-boot and "Uncompressing Kernel Image ... OK" printed on the screen. There are
> "vector: 200 at pc = c0197d4c, lr = c0197d40
> msr = 1030, sp = c0181fb0 [c0181f00]
> current = c0180020, pid = 0, comm = swapper
> mon>".
> It seemd the booting process had entered a monitor, but I didn't know what it was.
> 
> For the 2.6.17 kernel, after running bootm in u-boot, the booting process stops at "Uncompressing Kernel Image ... OK". No other output after this sentence on the screen.
> 
> Would you like to give some advice about this? Thanks a lot.       
> 

Hi,

FOA - asking one list is enough!
For 2.4 kernel, you've answered your question by yourself - (un)check the kernelconfig for xmon in 
kernel hacking menu - this should do the trick,
For 2.6 kernel: what about your bootargs settings? also check the console settings of your
kernel config.

HTH
Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 
