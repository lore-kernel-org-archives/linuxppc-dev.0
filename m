Message-ID: <20040528021150.75.qmail@sina.com>
From: lsshao <lsshao@sina.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: problems about powerpc8265 registers 
MIME-Version: 1.0
Date: Fri, 28 May 2004 10:11:50 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


PCI Agent Board:
	 POWERPC8265 Linux
Mother Board:
	PC(i386)  win2k
1)      win2k driver can correctly write mapped-registers by PCI bus,
but can't read mapped-registers (0x10430~0x10908) . Reading mapped-registers
by PCI bus leads to bluescreen(phylical memory down).
2)      win2k driver can correctly write inbound windows translated into SDRM by PCI bus.
Rsult of reading inbound windows  is a5a5a5a5 or 5a5a5a5a . That is to say , read data is not data after writing but data before writing.
3)     if win2k driver write the first DW of inbound windows , read data is data after writing .That is to say ,writing and reading are right.

why?!!!
______________________________________

◊¢≤·–¬¿À9’◊√‚∑—” œ‰£® http://mail.sina.com.cn/chooseMode.html £©

===================================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
