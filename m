Return-Path: <xerofoify@gmail.com>
Received: from mail-vc0-x235.google.com (mail-vc0-x235.google.com
 [IPv6:2607:f8b0:400c:c03::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79D601A000C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 12:45:17 +1000 (EST)
Received: by mail-vc0-f181.google.com with SMTP id il7so4884607vcb.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Jul 2014 19:45:14 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 7 Jul 2014 22:45:14 -0400
Message-ID: <CAPDOMVi5ptjaKzT+Exd3XtKcy7W7nNZYUD+MEwN8LmhPrQTZBQ@mail.gmail.com>
Subject: Allyesconfig for powerpc still Failing
From: Nick Krause <xerofoify@gmail.com>
To: benh@kernel.crashing.org
Content-Type: text/plain; charset=UTF-8
Cc: mahesh@linux.vnet.ibm.com, agraf@suse.de,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 michael@ellerman.id.au, paulus@samba.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Today I tested the allyesconfig for powerpc and it seems to be still
failing according to my tests.
Below are the error messages I get before the jobs finish and exit
failing the build.
Cheers Nick
arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
arch/powerpc/kernel/exceptions-64s.S:1331: Error: attempt to move .org backwards
make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1
make: *** [arch/powerpc/kernel] Error 2
make: *** Waiting for unfinished jobs....
