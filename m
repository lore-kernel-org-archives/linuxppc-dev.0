Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri2.pp.htv.fi (filtteri2.pp.htv.fi [213.243.153.185])
 by ozlabs.org (Postfix) with ESMTP id C2DC92C00A0
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2012 06:13:32 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
 by filtteri2.pp.htv.fi (Postfix) with ESMTP id 7F05A19B9E7
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2012 23:04:09 +0300 (EEST)
Received: from smtp4.welho.com ([213.243.153.38])
 by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
 with ESMTP id UWdi86M+bi1P for <linuxppc-dev@ozlabs.org>;
 Fri, 17 Aug 2012 23:04:09 +0300 (EEST)
Received: from harshnoise (212-149-209-232.bb.dnainternet.fi [212.149.209.232])
 by smtp4.welho.com (Postfix) with SMTP id 38F135BC010
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2012 23:04:08 +0300 (EEST)
Date: Fri, 17 Aug 2012 23:04:06 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: linuxppc-dev@ozlabs.org
Subject: PPC64 & DMA zone
Message-ID: <20120817200406.GA1908@harshnoise.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Is there a way to reduce/limit DMA zone with PPC64 kernel (3.6-rcX)
on G5 Mac? I have tried to search Kconfig or command line options,
but can't find anything.

The problem I have is that b43 driver (wireless chip) insists a 30-bit
DMA mask, but I have 1.5 GB physical memory. So the only way I can get
the wireless connection to work is to boot with "mem=1024MB". And as a
result my bloaty applications will loose much needed memory...

Thanks,

A.
