Message-ID: <B895EFF5AF34724880036BDB5B5B814813561F@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: mm_ptov() in pgtable.c
Date: Wed, 7 May 2003 14:37:52 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Does anyone know why we have mm_ptov() in
arch/ppc/mm/pgtable.c, since we already
have __va?  Is there a Really Good Reason,
historical accident, legacy from other
architectures, ... ?

Thanks.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
