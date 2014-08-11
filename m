Return-Path: <milkatoffeecuco@gmail.com>
Received: from mail-we0-x22c.google.com (mail-we0-x22c.google.com
 [IPv6:2a00:1450:400c:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 906271A0835
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 05:55:53 +1000 (EST)
Received: by mail-we0-f172.google.com with SMTP id x48so9115751wes.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 12:55:48 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 11 Aug 2014 21:55:48 +0200
Message-ID: <CAC_ERrD+zhWnHqwZyTp1hjQFRpS4MZ9KOAHdPAQLd4duEoDx+w@mail.gmail.com>
Subject: Mpc5125 nfc hw ecc problems
From: Daniel Mosquera <milkatoffeecuco@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=047d7b873762f6d9e605005ff02e
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b873762f6d9e605005ff02e
Content-Type: text/plain; charset=UTF-8

Hi,

I'm trying to port the nfc nand driver from 2.6.39.1 linux kernel to 3.14.4
using 4k nand blocks and 2k page size and 24bit hw ecc.

At the current time I have been able to make ecc, page read, and page write
to work but I cannot make oob read and write to work.

The main problem I'm facing is that I don't know how the ecc layout in the
spare area works in mpc5125.

Please, could anybody tell where I could get information about how to tell
linux the correct ecc oob parameters?

Thanks in advance,
Daniel

--047d7b873762f6d9e605005ff02e
Content-Type: text/html; charset=UTF-8

<p dir="ltr">Hi,</p>
<p dir="ltr">I&#39;m trying to port the nfc nand driver from 2.6.39.1 linux kernel to 3.14.4 using 4k nand blocks and 2k page size and 24bit hw ecc.</p>
<p dir="ltr">At the current time I have been able to make ecc, page read, and page write to work but I cannot make oob read and write to work.</p>
<p dir="ltr">The main problem I&#39;m facing is that I don&#39;t know how the ecc layout in the spare area works in mpc5125.</p>
<p dir="ltr">Please, could anybody tell where I could get information about how to tell linux the correct ecc oob parameters?</p>
<p dir="ltr">Thanks in advance,<br>
Daniel</p>

--047d7b873762f6d9e605005ff02e--
