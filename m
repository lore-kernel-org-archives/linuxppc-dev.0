Return-Path: <martin@hinner.info>
Received: from mail-qc0-f181.google.com (mail-qc0-f181.google.com
 [209.85.216.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EE0C914010D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 19:59:40 +1000 (EST)
Received: by mail-qc0-f181.google.com with SMTP id x3so1560990qcv.40
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 02:59:37 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 30 Apr 2014 11:59:37 +0200
Message-ID: <CAPVwjkycrRQsCDAOdHPh-jDvy1fgWbojiqM97+dSo6iaVXTe=g@mail.gmail.com>
Subject: GNU binutils & PowerPC VLE
From: Martin Hinner <martin@hinner.info>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

  I know this topic does not exactly fit this mailing list, but I
think it's better to ask here than on binutils.

  I need to assemble and disassemble some PowerPC VLE (variable length
encoding)  e200 code. Binutils as of 2.23.2 support VLE. But when I
try to use objdump -D with  -m powerpc:vle or -M vle I get plain
32-bit powerpc ISA disassembly (instead of 16bit instructions). Tried
to change input file format, endianity, etc. What am I doing wrong?

Thank you,

Martin
