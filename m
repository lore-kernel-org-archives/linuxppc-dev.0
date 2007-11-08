Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 9DFA3DDE35
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 08:47:25 +1100 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 08 Nov 2007 22:47:23 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20071108214723.135260@gmx.net>
MIME-Version: 1.0
Subject: Kernel locks up after calling kernel_execve()
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I tested my patches for the AmigaOne platform with the lastest 2.6.24-rc2
kernel snapshot. The kernel runs through all initcalls, but locks up
completely after calling INIT (/sbin/init) by kernel_execve(). Thus I
couldn't capture any kernel oops or panic output. Also the magic sysrq
key doesn't work. Enabling debug code for soft lockups and spinlock
debugging didn't reveal any information.
I'm not sure, but I think it is the same problem I had with all kernels
>= 2.6.17. All of these kernels lock up shortly before or right at calling
the init program (resp. as soon as the kernel forks some kernel theads).
Any suggestions on how to track down this problem?

regards,

Gerhard

-- 
Ist Ihr Browser Vista-kompatibel? Jetzt die neuesten 
Browser-Versionen downloaden: http://www.gmx.net/de/go/browser
