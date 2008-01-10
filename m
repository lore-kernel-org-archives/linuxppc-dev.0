Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 01FE0DE0CD
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 03:04:29 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so162219anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 08:04:28 -0800 (PST)
Message-ID: <fa686aa40801100804g149822a4ybdeb0b19294f3f94@mail.gmail.com>
Date: Thu, 10 Jan 2008 09:04:28 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Please pull linux-2.6-mpc52xx for-2.6.24
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Can you please pull this tree to get an Efika boot fix into 2.6.24.
Without this fix, Ethernet on the Efika will not work without the user
jumping through all kinds of hoops.

Thanks,
g.

The following changes since commit fd0b45dfd1858c6b49d06355a460bcf36d654c06:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../davem/net-2.6

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git for-2.6.24

Olaf Hering (1):
      [POWERPC] efika: add phy-handle property for fec_mpc52xx

 arch/powerpc/kernel/prom_init.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
