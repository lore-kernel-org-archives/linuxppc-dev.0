Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.247])
	by ozlabs.org (Postfix) with ESMTP id 7959DDDEDA
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 02:37:10 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so957478agc.0
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 07:37:08 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 6 Mar 2009 08:37:07 -0700
Message-ID: <fa686aa40903060737r684b3daejfe59cbd41e679751@mail.gmail.com>
Subject: Please pull mpc52xx-merge
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

One last one for 2.6.29.  Single line cefconfig change only.  This
fixes defconfigs for Xilinx Virtex platforms that use the full 16550
uart instead of uartlite.

The following changes since commit 778ef1e6cbb049c9bcbf405936ee6f2b6e451892:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../gregkh/staging-2.6

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git merge

Grant Likely (1):
      powerpc/4xx: Enable SERIAL_OF support by default for Virtex platforms

 arch/powerpc/configs/40x/virtex_defconfig  |    2 +-
 arch/powerpc/configs/44x/virtex5_defconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
