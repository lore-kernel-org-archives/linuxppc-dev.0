Message-ID: <3E239B1A.9040107@redswitch.com>
Date: Mon, 13 Jan 2003 21:07:38 -0800
From: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Configure 8xx_io in 2.4.21-pre3
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The 8xx CPM configuration in 2.4.4 release from DENX has more options
than any other release, including 2.4.21-pre3. For example,
CONFIG_SMC1_UART is in 2.4.4 (DENX). My board uses SMC1 as UART. I
almost needn't to change anything in 2.4.4-denx to make my 8xx CPM
working. I'm trying to migrate the kernel to 2.4.21 and the kernel is
stuck in my_console_write() and no any message is shown on the console.
So I think the problem is in CPM settings. I enabled the following
configuations for MPC8xx CPM.
CONFIG_FEC_ENET=y
CONFIG_USE_MDIO=y
CONFIG_FEC_LXT971=y
CONFIG_8xx_COPYBACK=y
CONFIG_UCODE_PATCH=y

How can I set CPM correctly in 2.4.21? Any hints are greatly appreciated.

- Shawn.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
