Return-Path: <rickard_strandqvist@spectrumdigital.se>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
 [74.125.82.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3F371A04F5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jun 2014 02:24:19 +1000 (EST)
Received: by mail-we0-f170.google.com with SMTP id w61so4033043wes.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 09:24:13 -0700 (PDT)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] arch: powerpc: platforms: cell: cbe_thermal.c: Cleaning up a
 variable is of the wrong type
Date: Sat, 14 Jun 2014 18:25:10 +0200
Message-Id: <1402763111-23458-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This variable is of the wrong type, everywhere it is used it
should be an unsigned int rather than a int.

This was partly found using a static code analysis program called cppcheck.

Rickard Strandqvist (1):
  arch: powerpc: platforms: cell: cbe_thermal.c:  Cleaning up a variable is of the wrong type

 arch/powerpc/platforms/cell/cbe_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.7.10.4
