Message-ID: <39CF1EA3.E9320359@centurysys.co.jp>
Date: Mon, 25 Sep 2000 18:45:07 +0900
From: Tania Boak <tania@centurysys.co.jp>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: SCU_PMSR_TEVP definition in commproc.h
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I think we may have found a mistake in the definition of SCU_PMSR_TEVP
in arch/ppc/8xx_io/commproc.h.  We are using a 2.2.13 kernel so please
disregard if this has already been fixed.  I think the definition should
be changed to

#define SCU_PMSR_TEVP    ((ushort)0x0002)

The value of 0x0003 in the file I have forces high parity when even
parity is desired.

Tania


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
