Return-Path: <carlos.moratelli@digitel.com.br>
Received: from ares.digitel.com.br (cosmos.digitel.com.br [200.198.105.42])
	by ozlabs.org (Postfix) with ESMTP id A0867DDDB6
	for <linuxppc-dev@ozlabs.org>; Wed,  6 May 2009 02:15:19 +1000 (EST)
Received: from [192.168.20.56] (unknown [192.168.20.56])
	by ares.digitel.com.br (Postfix) with ESMTP id 2BA0C27852A
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 13:05:13 -0300 (BRT)
Subject: modprobe problem
From: Carlos Roberto Moratelli <carlos.moratelli@digitel.com.br>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <mailman.7049.1241524613.26545.linuxppc-dev@ozlabs.org>
References: <mailman.7049.1241524613.26545.linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 05 May 2009 13:00:25 -0300
Message-Id: <1241539225.12070.48.camel@parana>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I have a Kernel 2.6.24 running on a custom board based on mpc8313erdb.
My filesystem is composed by a read-only squashfs and a read-write jffs2
filesystems. A unionfs is used to unificate the filesystems.

Like you know, when a file on my read-only squasfs is modified such file
is copied to read-write jffs2 partition by unionfs. So, when you try to
read such file again, the modified copy on jffs2 will be used.

The kernel modules (.ko) are on squashfs and I am using modprobe to load
the kernel modules. 

THE PROBLEM is when I try load a module using modprobe, this module is
copied from squashfs to jffs2 filesystem. But, my intention is not
modify the module, just load it. 

I am supposing that is a problem because the modules are using
duplicated space in flash and I don't want to store the modules in jffs2
because the compression is lower.

Does someone know why this happend?

Thanks,

Moratelli




 
