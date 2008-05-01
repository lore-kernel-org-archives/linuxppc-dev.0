Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 2FDECDDF9F
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 04:04:16 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so287099anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 01 May 2008 11:04:15 -0700 (PDT)
Message-ID: <fa686aa40805011104x487e6be8u1aa2e49c4473c085@mail.gmail.com>
Date: Thu, 1 May 2008 12:04:14 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>, shengping.liu@windriver.com,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Please pull linux-2.6-mpc52xx.git
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul, here's a couple more for 2.6.26.  One bug fix and one minor
change that I've had on the back burner for a month or so.  This
should be the last of any non-bugfix changes through my tree.

Cheers,
g.

git-request-pull powerpc git://git.secretlab.ca/git/linux-2.6-mpc52xx.git
The following changes since commit eabd90944b3a00766e84da3d117ea0f3e0a3b1a3:
  Michael Ellerman (1):
        [POWERPC] Fix crashkernel= handling when no crashkernel= specified

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git for-2.6.26

Andrew Liu (1):
      Fix a potential issue in mpc52xx uart driver

Grant Likely (1):
      [POWERPC] mpc5200: Allow for fixed speed MII configurations

 .../powerpc/mpc52xx-device-tree-bindings.txt       |   11 ++
 drivers/net/fec_mpc52xx.c                          |   97 +++++++++++++++-----
 drivers/net/fec_mpc52xx.h                          |   19 ----
 drivers/serial/mpc52xx_uart.c                      |    2 +
 4 files changed, 87 insertions(+), 42 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
