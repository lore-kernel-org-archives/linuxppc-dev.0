Message-Id: <200310141321.IAA20337@lists.linuxppc.org>
From: "Yuxiao Xi" <xiyuxiao@harbournetworks.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: question about KGDB for sandpoint with MPC8240 
Mime-Version: 1.0
Content-Type: text/plain
Date: Tue, 14 Oct 2003 20:35:32 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
    Where can I find a KGDB patch to support kernel debugging MontaVista
2.1 for sandpoint with MPC8240? I selected "CONFIG_KGDB" when do "make
xconfig",but KGDB seemed not to work. I stole file gen550_kgdb.c and
gen550_dbg.c from linux-2.6.0, but KGDB seemed not to work yet.

　　　　　　　　Yuxiao Xi
　　　　　　　　xiyuxiao@harbournetworks.com
　　　　　　　　　　2003-10-14

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
