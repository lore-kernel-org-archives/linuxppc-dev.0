Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18478.26326.727525.687997@cargo.ozlabs.ibm.com>
Date: Sat, 17 May 2008 15:02:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to powerpc.git powerpc-next branch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have pulled Linus' tree into the powerpc-next branch of powerpc.git,
and added the following 4 patches.

Paul.

Paul Mackerras (1):
      [POWERPC] Defer processing of interrupts when the CPU wakes from sleep mode

Robert P. J. Day (1):
      [POWERPC] Get most of ioctl.h content from <asm-generic/ioctl.h>

Scott Wood (1):
      [POWERPC] Add 6xx-style HID0_SLEEP support.

Stephen Rothwell (1):
      [POWERPC] Move of_device_get_modalias to drivers/of
