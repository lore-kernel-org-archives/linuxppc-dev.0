Return-Path: <vneethv@gmail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4271B2C007F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 16:16:20 +1000 (EST)
Received: by bkcjk13 with SMTP id jk13so116940bkc.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2012 23:16:17 -0700 (PDT)
MIME-Version: 1.0
From: Vineeth <vneethv@gmail.com>
Date: Wed, 4 Jul 2012 11:45:56 +0530
Message-ID: <CAFbQSaDWXTg429q-tTRvcgAEsA1OmHzFVhPNOmSRnWjMpSZfpA@mail.gmail.com>
Subject: rionet driver with MMIO DMA capability
To: linux-embedded@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linuxppc-embedded@ozlabs.org, Scott Wood <scottwood@freescale.com>,
 mporter@kernel.crashing.org
Content-Type: multipart/alternative; boundary=0015175cb67a03096004c3faf89b
Cc: ranenikhil19@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0015175cb67a03096004c3faf89b
Content-Type: text/plain; charset=ISO-8859-1

Hi,

With kernel mainstream version 3.5.rc-5 there's SRIO low level driver with
DMA support for MMIO. But the rionet driver in the same kernel version
doesnt support MMIO.

We are trying to find the maximum bandwidth that we can achieve using our
custom board's(quad MPC8641 )  4-lane SRIO.
Now we are worried how to use this SRIO low level driver effectively ?

The RIOnet driver (with 3.5.-rc5) uses message based communication. This
doesnt use the DMA capability of low level driver. with this we are getting
a bandwidth of nearly 900Mbps, which is very less.

Is there any example code or modified middle ware driver for rionet/ or any
code which uses the low level driver apis with MMIO DMA??


Thanks
Vineeth

--0015175cb67a03096004c3faf89b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>Hi,<br><br>With kernel mainstream version 3.5.rc-5 there&#39;s SRIO low=
 level driver with DMA support for MMIO. But the rionet driver in the same =
kernel version doesnt support MMIO. <br><br>We are trying to find the maxim=
um bandwidth that we can achieve using our custom board&#39;s(quad MPC8641 =
)=A0 4-lane SRIO. <br>

Now we are worried how to use this SRIO low level driver effectively ? <br>=
<br>The RIOnet driver (with 3.5.-rc5) uses message based communication. Thi=
s doesnt use the DMA capability of low level driver. with this we are getti=
ng a bandwidth of nearly 900Mbps, which is very less.<br>

<br>Is there any example code or modified middle ware driver for rionet/ or=
 any code which uses the low level driver apis with MMIO DMA??<br><br><br>T=
hanks<br>Vineeth<br>

--0015175cb67a03096004c3faf89b--
