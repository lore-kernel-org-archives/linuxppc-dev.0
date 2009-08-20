Return-Path: <thirumalai.p@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9E2F3B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 14:15:06 +1000 (EST)
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id E056BDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 14:15:04 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b6so1887837ana.39
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 21:15:02 -0700 (PDT)
MIME-Version: 1.0
Sender: thirumalai.p@gmail.com
Date: Thu, 20 Aug 2009 12:15:02 +0800
Message-ID: <e1ca2e7b0908192115o2cfa427fof21512757854901a@mail.gmail.com>
Subject: Regarding TSI108 ethernet DMA issue
From: Thirumalai Pachamuthu <thirumalai.p@datapatterns.co.in>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: multipart/alternative; boundary=001636ed740de1be4904718afe5a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636ed740de1be4904718afe5a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,
      I am trying to port linux 2.6.30 for my TSI108 based custom board
where i am getting the following kernel panic message. I found that it was
due to dma allocation function call particularly dma_alloc_coherent() of
tsi108_open function. When we see the implementation of dma_alloc_coherent.
It was bit changed from the previous linux versions it seems.
      The implementation of dma_alloc_coherent was kept on the
arch/powerpc/include/asm/dma-mapping.h file. Earlier implementation is not
considering the first parameter what the tsi108 driver is passing as NULL.
But the current implementation is considering this parameter and because of
this the panic is coming what i believe.

      So kindly let me know any patches for this problem or any fixes.
Regards,
T.

--001636ed740de1be4904718afe5a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi all,</div>
<div>=A0=A0=A0=A0=A0 I am trying to port linux 2.6.30 for my TSI108 based c=
ustom board where i am getting the following kernel panic message. I found =
that it was due to dma allocation function call particularly dma_alloc_cohe=
rent() of tsi108_open function. When we see the implementation of dma_alloc=
_coherent. It was bit changed from the previous linux versions it seems. </=
div>

<div>=A0=A0=A0=A0=A0 The implementation of dma_alloc_coherent was kept on t=
he arch/powerpc/include/asm/dma-mapping.h file. Earlier implementation is n=
ot considering the first parameter what the tsi108 driver is passing as NUL=
L. But the current implementation is considering this parameter and because=
 of this the panic is coming what i believe.</div>

<div>=A0</div>
<div>=A0=A0=A0=A0=A0 So kindly let me know any patches for this problem or =
any fixes.</div>
<div>Regards,</div>
<div>T.</div>

--001636ed740de1be4904718afe5a--
