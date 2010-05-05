Return-Path: <timur.tabi@gmail.com>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id AE91EB7D63
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 21:51:53 +1000 (EST)
Received: by pxi18 with SMTP id 18so2374781pxi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 05 May 2010 04:51:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3A45394FD742FA419B760BB8D398F9ED0183AF33@zch01exm26.fsl.freescale.net>
References: <3A45394FD742FA419B760BB8D398F9ED0183AF33@zch01exm26.fsl.freescale.net>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Wed, 5 May 2010 06:51:22 -0500
Message-ID: <u2ted82fe3e1005050451q96498ce9jc9f5c0650e00ae2d@mail.gmail.com>
Subject: Re: Page fault on vmalloc'ed memory
To: Li Yang-R58472 <r58472@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 5, 2010 at 12:19 AM, Li Yang-R58472 <r58472@freescale.com> wrot=
e:
> I got a weird page fault oops on vmalloc'ed area. =A0Digging into the pow=
erpc do_page_fault(), I found there is no handling of address in kernel spa=
ce unlike the x86 counter part. =A0Does any one know how we deal with the v=
malloc'ed area on powerpc? =A0Thanks a lot.

Can you be more specific?  Post the oops message, and tell us the
specific x86 code that you think is missing.

--=20
Timur Tabi
Linux kernel developer at Freescale
