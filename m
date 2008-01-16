Return-Path: <vbendeb@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by ozlabs.org (Postfix) with ESMTP id E683CDDE25
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jan 2008 17:03:50 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so117038nzh.39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jan 2008 22:03:49 -0800 (PST)
Message-ID: <f608b67d0801152203j523ebdeavbab4412121a31a7@mail.gmail.com>
Date: Tue, 15 Jan 2008 22:03:48 -0800
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: MPIC ISU
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings,

I am trying to write a BSP for an 8245 based device. One thing which
really gets me puzzled is the 'ISU' facility in
arch/powerpc/sysdev/mpic.c, there is also a notion of ISU-less
platforms, etc. I looked through the chip's programmer's reference,
even read the original AMD/Cypress OpenPIC specification - not a clue.

What is it, at the very least - what does ISU stand for?

I would really appreciate any hints,

thank you in advance,
/vb
