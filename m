Return-Path: <vbendeb@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id 57F6EDDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Jan 2008 07:32:54 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2375978pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 20 Jan 2008 12:32:53 -0800 (PST)
Message-ID: <f608b67d0801201232x1f48496gda475143e9da3c76@mail.gmail.com>
Date: Sun, 20 Jan 2008 12:32:52 -0800
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Fwd: MPIC ISU
In-Reply-To: <f608b67d0801201216o60be67a1w3ead9714c3bba5aa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f608b67d0801152203j523ebdeavbab4412121a31a7@mail.gmail.com>
	<57351E05-13DE-48F0-B0E5-28AADEF288A1@kernel.crashing.org>
	<f608b67d0801181044j352ee94dl50ea291164f4cb17@mail.gmail.com>
	<823F3BC7-FF4E-4DA7-B000-9C128016ACB3@kernel.crashing.org>
	<f608b67d0801201216o60be67a1w3ead9714c3bba5aa@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[add linuxppc-embedded@ozlabs.org,]

On Jan 19, 2008 8:19 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>

> >
> > what platform is linkstation and what kernel version can I find it in?
>
> arch/powerpc/platforms/embedded6xx/linkstation.c
>
> you should be able to find it 2.6.23 or newer.
>

Kumar, thank you for this clarification, I see this file in the latest kernel.

One more question, just out of curiosity - why is it in
platforms/embedded6xx and not in platforms/82xx - is there any
explicit reason for this distinction?

TIA,
/vb

> - k
>
>
