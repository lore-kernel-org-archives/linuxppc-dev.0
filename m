Return-Path: <dhbaird@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 4C5D4DDEFC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Feb 2008 04:17:15 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so116274wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 09:17:13 -0800 (PST)
Message-ID: <440abda90802130917x79c3c990j6a1fc7c12ba05ed7@mail.gmail.com>
Date: Wed, 13 Feb 2008 10:17:13 -0700
From: "David Baird" <dhbaird@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: TLB Miss booting linux kernel on ppc 405
In-Reply-To: <5ee408090802130850w130ce09an507ca5c4d41cc5a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5ee408090802130850w130ce09an507ca5c4d41cc5a8@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Feb 13, 2008 9:50 AM, Ricardo Ayres Severo <severo.ricardo@gmail.com> wrote:
> Hi All,
>
> I'm using kernel 2.6.24 and when it comes to line 826 on the file
> arch/ppc/kernel/head_4xx.S it gives a TLB Miss.
>
> arch/ppc/kernel/head_4xx.S
> 823 start_here:
> 824
> 825         /* ptr to current */
> 826         lis    r2,init_task@h
> 827         ori    r2,r2,init_task@l

I am just curious: how did you find that you have TLB miss on that
line?  Is it an Instruction TLB miss or a Data TLB miss?

Can you paste a dump of your registers (in XMD, rrd and srrd)?

I was having TLB misses awhile back due to some other problems, but
never had any on that line though.
