Return-Path: <andy.grover@oracle.com>
Received: from rgminet14.oracle.com (rcsinet14.oracle.com [148.87.113.126])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rgminet14.oracle.com",
	Issuer "VeriSign Class 3 Secure Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EDA2FDDFC9
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 17:28:07 +1100 (EST)
Received: from rgminet13.oracle.com (rcsinet13.oracle.com [148.87.113.125])
	by rgminet14.oracle.com (Switch-3.3.1/Switch-3.3.1) with ESMTP id
	n245VeO1007014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Mar 2009 05:31:41 GMT
Message-ID: <49AE114C.6070903@oracle.com>
Date: Tue, 03 Mar 2009 21:27:40 -0800
From: Andy Grover <andy.grover@oracle.com>
MIME-Version: 1.0
To: david@gibson.dropbear.id.au
Subject: ext2_* in bitops.h
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Can the ext2_* definitions in arch/powerpc/include/asm/bitops.h be 
replaced with:

#include <include/asm-generic/bitops/ext2-non-atomic.h>
#include <include/asm-generic/bitops/ext2-atomic.h>

?

Also, can the bitop swizzling (starting at line 351) be removed by 
including include/asm-generic/bitops/le.h? It looks very similar if not 
identical.

I'm afraid I don't have a ppc to test on so I wanted to see what you all 
thought.

Regards -- Andy
