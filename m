Return-Path: <jonmasters@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.196])
	by ozlabs.org (Postfix) with ESMTP id 5B8BF2BDB2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Sep 2004 22:05:29 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 76so4431335rnk
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Sep 2004 05:05:26 -0700 (PDT)
Message-ID: <35fb2e59040929045822511b4b@mail.gmail.com>
Date: Wed, 29 Sep 2004 12:58:46 +0100
From: Jon Masters <jonmasters@gmail.com>
To: Piotr Perak <peri@aqua.aspd.pwr.wroc.pl>
In-Reply-To: <Pine.LNX.4.21.0409291256250.3154-100000@aqua.aspd.pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <20040928094327.B1532@home.com>
	<Pine.LNX.4.21.0409291256250.3154-100000@aqua.aspd.pwr.wroc.pl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 2.6.x on 405CR
Reply-To: jonathan@jonmasters.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 29 Sep 2004 13:20:17 +0200 (CEST), Piotr Perak
<peri@aqua.aspd.pwr.wroc.pl> wrote:

> I'm a trainee in some firm. They use 2.4.23 now in their boxes.

Well you and I have the 2.4.23 bit in common. I'm the entire kernel
team in the company I work at, which is somewhat fun. Also means lists
like this are really useful on occasion.

> Porting 2.6.8.1 to their board is my project. I was told that they have some
> hardware debbuger, but it doesn't work with virtual memory.

I don't have one capable of working with virtual memory but I do have
a JTAG debugger since JTAG is used to program all of our boards - and
using insight with a large cup of coffee, System.map and the output of
a full objdump of the kernel binary in combination with modifying the
code in memory to insert infinate loops or changing the mode in the
MSR usually works for me. Seriously, if you don't have a vm capable
debugger that's a lot of masochistic fun to be had debugging.

Jon.
