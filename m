Return-Path: <kylo.ginsberg@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.206])
	by ozlabs.org (Postfix) with ESMTP id E09E268734
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Nov 2005 06:05:52 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id i2so660298wra
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 20 Nov 2005 11:05:51 -0800 (PST)
Message-ID: <61cc712d0511201058p367df361i7e46591336918712@mail.gmail.com>
Date: Sun, 20 Nov 2005 10:58:26 -0800
From: Kylo Ginsberg <kylo.ginsberg@gmail.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20051119152413.D0B44353BEF@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <6AD9F6A5F6E096408F0B703773355A0765E931@CHN-SNR-MBX01.wipro.com>
	<20051119152413.D0B44353BEF@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Memtest-SDRAM
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/19/05, Wolfgang Denk <wd@denx.de> wrote:
> In message <6AD9F6A5F6E096408F0B703773355A0765E931@CHN-SNR-MBX01.wipro.co=
m> you wrote:
> >
> >   Can I comprehensively test and conform that my SDRAM is creating
> > problem other than mtest at u-boot( which I already implemented the
> > mtest with the help of mailing list , where my memory failed . ) , if i=
s
> > there is a way please do let me know .
>
> A simple test is: if Linux is running  without  problems  under  load
> than there are no problems with your SDRAM.

Yes, but determining the proper load to test with can be tricky.=20
E.g., I had a subtle memory timing issue that only turned up under
very peculiar circumstances under linux; this was very difficult to
reproduce until I started using a simple user-space memory tester
application, which could very reliably produce failures.  Fwiw, I
started with this:

http://pyropus.ca/software/memtester/

Cheers,
Kylo
