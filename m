Date: Tue, 20 Jan 2004 14:34:13 +0900
Mime-Version: 1.0 (Apple Message framework v553)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: local_irq_enable() problem...
From: Etsushi Kato <ekato@ees.hokudai.ac.jp>
To: linuxppc-dev@lists.linuxppc.org
Message-Id: <4824AFEC-4B0A-11D8-A780-00039394E428@ees.hokudai.ac.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just started porting Linux 2.6 for nubus powermac.  I've applied most
of 2.4 nubus patch to 2.6.1-rc2, and kernel compiles fine now.  But in
the early booting of kernel, it hangs while doing local_irq_enable()
just after profile_init() in start_kernel() of init/main.c.

How can I debug kernel in this situation?  printk() is working, and
boot messages are shown with serial connection until "Console: colour
dummy device 80x25".
Maybe it is related arch/ppc/kernel/head.S and entry.S ??

Thanks in advance,
--
Etsushi Kato
ekato@ees.hokudai.ac.jp


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
