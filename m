Return-Path: <leon.woestenberg@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 2DE3FDDDF6
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 23:04:55 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so1131846qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Oct 2008 05:04:54 -0700 (PDT)
Message-ID: <c384c5ea0810090504x570cb6aai6d136a150e74ac05@mail.gmail.com>
Date: Thu, 9 Oct 2008 14:04:53 +0200
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: "Dominik Bozek" <domino@mikroswiat.pl>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
In-Reply-To: <48EDEDDB.1040102@mikroswiat.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <48ECC611.3030309@mikroswiat.pl>
	<20081008154212.GA21723@secretlab.ca>
	<18669.28058.495259.72182@cargo.ozlabs.ibm.com>
	<48EDD905.6070609@mikroswiat.pl>
	<18669.58803.48011.686743@cargo.ozlabs.ibm.com>
	<48EDEDDB.1040102@mikroswiat.pl>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,

On Thu, Oct 9, 2008 at 1:41 PM, Dominik Bozek <domino@mikroswiat.pl> wrote:
> Paul Mackerras wrote:
>> Dominik Bozek writes:
>>> Actually I made couple of other tests on that mpc8313. Most of them are
>>> to ugly to publish them, but... My problem is that I have to boost the
>>> gigabit interface on the mpc8313. I made simple substitution and
>>
>> Very interesting.  Can you work out where memcpy is being called on
>> the network data?  I wouldn't have expected that.
>>

Also see this recent thread David Jander on August 25th, "Efficient
memcpy()/memmove() for G2/G3 cores..."
on linuxppc-dev@ozlabs.org.

http://ozlabs.org/pipermail/linuxppc-dev/2008-September/062449.html

BTW, I am interested in this work as well, I'm currently working with
a 8313 and 8315 design, both are e300 cores.

My current goal is PCIe though, but I need fast GbE performance as well.

Also, did you test Freescale's 2.6.24.3 patches that tune the gianfar
interfaces for higher performance?

Regards,
-- 
Leon
