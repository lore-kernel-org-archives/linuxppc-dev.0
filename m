Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E8C34DDE06
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 14:56:00 +1100 (EST)
Date: Fri, 25 Jan 2008 22:07:54 -0600
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: Please pull for-2.6.25 branch of pasemi.git
Message-ID: <20080126040754.GA29143@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull from 'for-2.6.25' branch of

  master.kernel.org:/pub/scm/linux/kernel/git/olof/pasemi.git for-2.6.25

to receive the following updates:

 arch/powerpc/kernel/smp.c |   49 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 13 deletions(-)

Olof Johansson (2):
      [POWERPC] smp_call_function_map should be static
      [POWERPC] Make smp_send_stop() handle panic and xmon reboot


Those two patches are marked as "awaiting upstream" in patchwork, but
I didn't see them in powerpc.git for-2.6.25.


-Olof
