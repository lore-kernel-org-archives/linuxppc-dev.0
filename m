Return-Path: <ayoub_zaki@yahoo.fr>
Date: Mon, 15 Sep 2008 09:13:23 +0000 (GMT)
From: ayoub zaki <ayoub_zaki@yahoo.fr>
Subject: PCI Post Boot scan
To: Linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-ID: <428769.16820.qm@web26608.mail.ukl.yahoo.com>
Reply-To: ayoub_zaki@yahoo.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi all,

I'm working on a mpc8572ds based board from freescale.

I have an onboard FPGA (PCI express) that I want to configure from the user=
space application with the corresponding "firmware".=20

Only after a configuration that the FPGA shows its PCI nature.

the problem is that linux has no way to detect the PCI device unless I rebo=
ot my board.

fakephp wouldn't help scince my device is not configured at the boot time.

Is there any way to do it so ?

Is it possible to re-initialize the whole pci stack again ?

Thanks for any kind help

Ayoub Zaki



=0A=0A=0A      
