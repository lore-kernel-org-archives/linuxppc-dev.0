Return-Path: <runaway@candw.ms>
Received: from mail-vn0-f48.google.com (mail-vn0-f48.google.com
 [209.85.216.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CEACE1A0244
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 20:59:48 +1000 (AEST)
Received: by vnbg7 with SMTP id g7so11250628vnb.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 03:59:46 -0700 (PDT)
Message-ID: <553E16A0.704@candw.ms>
Date: Mon, 27 Apr 2015 06:59:44 -0400
From: Julian Margetson <runaway@candw.ms>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Kernel 4.1-rc1 build fails on Sam460ex amcc 460ex powerpc Canyonlands
References: <54E08E06.8060607@candw.ms>
 <1424045921.3018.4.camel@ellerman.id.au>
In-Reply-To: <1424045921.3018.4.camel@ellerman.id.au>
Content-Type: multipart/alternative;
 boundary="------------000106000808040002080604"
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000106000808040002080604
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Kernel 4.1-rc1 build fails  on Sam460ex amcc 460ex powerpc Canyonlands with
CONFIG_SATA_DWC=y

sata_dwc_460ex.c:(.text+0xa165c): undefined reference to `dw_dma_remove'
drivers/built-in.o: In function `sata_dwc_probe':
sata_dwc_460ex.c:(.text+0xa1900): undefined reference to `dw_dma_probe'
sata_dwc_460ex.c:(.text+0xa1954): undefined reference to `dw_dma_remove'
make: *** [vmlinux] Error 1


--------------000106000808040002080604
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <pre class="western">Kernel 4.1-rc1 build fails  on Sam460ex amcc 460ex powerpc Canyonlands with 
CONFIG_SATA_DWC=y

sata_dwc_460ex.c:(.text+0xa165c): undefined reference to `dw_dma_remove'
drivers/built-in.o: In function `sata_dwc_probe':
sata_dwc_460ex.c:(.text+0xa1900): undefined reference to `dw_dma_probe'
sata_dwc_460ex.c:(.text+0xa1954): undefined reference to `dw_dma_remove'
make: *** [vmlinux] Error 1</pre>
    <title></title>
    <meta name="generator" content="LibreOffice 4.3.5.2 (Windows)">
    <meta name="created" content="00:00:00">
    <meta name="changed" content="00:00:00">
    <style type="text/css">
		@page { margin: 0.79in }
		pre.cjk { font-family: "NSimSun", monospace }
		p { margin-bottom: 0.1in; line-height: 120% }
		a:link { so-language: zxx }
	</style>
  </body>
</html>

--------------000106000808040002080604--
