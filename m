Return-Path: <rscop@matrix.com.br>
Received: from cosmos.digitel.com.br (cosmos.digitel.com.br [200.198.105.42])
	by ozlabs.org (Postfix) with ESMTP id C8E02DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 15:17:59 +1000 (EST)
From: Ricardo Scop <rscop@matrix.com.br>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ppc_8xx-gcc from eldk strange behaviour
Date: Wed, 29 Aug 2007 01:50:46 -0300
References: <F1F6EC0C8B75034F9E3A79FC85122E8E2649AF@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E2649AF@aquib01a>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200708290150.46317.rscop@matrix.com.br>
Cc: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Antonio

On Tuesday 28 August 2007 15:56, DI BACCO ANTONIO - technolabs wrote:
> Consider the following C code snippet:
[snip]
>   char x = -4;
[snip]
>
> If I compile it with host gcc, there is no warning and the message "x is
> negative" is printed. If I compile it with ppc_8xx-gcc there is a warning
> "main.c:11: warning: comparison is always false due to limited range of
> data type" and the program prints message "x is positive". To correct the
> problem I have to put signed before char.
>

You can also use the -fsigned-char compilation flag, in this case.

-- 
Ricardo Scop.
