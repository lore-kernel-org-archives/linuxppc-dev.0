Return-Path: <dcarroll@astekcorp.com>
Received: from ether.astekcorp.com (unknown [173.160.34.133])
	by ozlabs.org (Postfix) with ESMTP id 70A2DB6FB6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 02:50:27 +1000 (EST)
From: Dave Carroll <dcarroll@astekcorp.com>
To: Dave Carroll <dcarroll@astekcorp.com>, 'Milton Miller' <miltonm@bga.com>
Date: Mon, 23 May 2011 10:50:07 -0600
Subject: RE: [ v4] powerpc: Force page alignment for initrd reserved memory
Message-ID: <522F24EF533FC546962ECFA2054FF777373072AB78@MAILSERVER2.cos.astekcorp.com>
In-Reply-To: <522F24EF533FC546962ECFA2054FF777373072AB75@MAILSERVER2.cos.astekcorp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, LPPC <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I'm withdrawing this patch for the moment, due to two areas that need furth=
er research;

1) An adjacent FDT blob, as mentioned by Milton Miller, and

2) Potential interaction with the crash kernel, as used in
        init/initramfs.c

If anyone sees other interactions, please feel free to let me know ...

Thanks,
-Dave Carroll
