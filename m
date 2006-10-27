Return-Path: <fabbione@ubuntu.com>
Received: from trider-g7.fabbione.net (trider-g7.fabbione.net [195.22.207.161])
	by ozlabs.org (Postfix) with ESMTP id B1C3667D13
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 16:13:09 +1000 (EST)
Message-ID: <45419F79.2020300@ubuntu.com>
Date: Fri, 27 Oct 2006 07:56:09 +0200
From: Fabio Massimo Di Nitto <fabbione@ubuntu.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: glibc-2.5 test suite hangs/crashes the machine
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Jeff Bailey <jbailey@ubuntu.com>,
	Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi everybody,

i am in the process of bootstrapping the new toolchain for ubuntu and I am
hitting a problem building glibc-2.5 on ppc.

This behaviour has been reproduced on 2.6.15/2.6.17 and 2.6.19-rc2 (where the
machine crashes) and with ppc32 and ppc64 kernels.
A hard reboot of the machine is required to get rid of the Zl processes hanging
around that keep spinning the CPU at 100%.

I did place sources here: http://people.ubuntu.com/~fabbione/benh/

but i start to believe it is a kernel bug we are exploiting only now.

Any hint or help for what to look for would be extremely appreciated.

Thanks
Fabio

-- 
I'm going to make him an offer he can't refuse.
