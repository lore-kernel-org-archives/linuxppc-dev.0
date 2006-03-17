Return-Path: <jimmyzhmliu@yahoo.com>
Received: from web53111.mail.yahoo.com (web53111.mail.yahoo.com
	[206.190.49.61]) by ozlabs.org (Postfix) with SMTP id 28667679E0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Mar 2006 02:42:31 +1100 (EST)
Message-ID: <20060317153550.19366.qmail@web53111.mail.yahoo.com>
Date: Fri, 17 Mar 2006 07:35:50 -0800 (PST)
From: jimmy liu <jimmyzhmliu@yahoo.com>
Subject: Linux kernel reboot issue
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <mailman.327.1141665606.16671.linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Our custom board is similar as EST8260. We use Linux
Kernel 2.4.25 from ftp://ftp.denx.de/pub/linux/. When
we type the reboot command or shutdown -r, we got the
following error messages. Does anybody has idea? 

The system is going down NOW !!
Sending SIGTERM to all processeTerminated
Sending SIGKILL to all processes.
Please stand by while rebooting the system.
Restarting systemsteOops: Exception in kernel mode,
sig: 4
NIP: FFF00100 XER: 00000000 LR: FFF00100 SP: C0EDDDF0
REGS: c0eddd40 TRAP: 0700    Not tainted
MSR: 00081002 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c0edc000[34] 'init' Last syscall: 2
last math 00000000 last altivec 00000000
GPR00: 00001032 C0EDDDF0 C0EDC000 001EDA88 FFF00100
00001002 000037D0 00000000
GPR08: C0374060 C000C024 0000C000 00100088 0000000D
10064B24 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00009032
00EDDF40 00000000 C0003EA8
GPR24: C0003C00 100034DC 7FFFFF38 00000001 7FFFFF24
00000000 FFF00100 00000000
Call backtrace:
00000000



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
