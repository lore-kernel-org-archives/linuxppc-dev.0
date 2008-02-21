Return-Path: <dhbaird@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 725CEDDE09
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Feb 2008 05:00:42 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so122005wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 10:00:41 -0800 (PST)
Message-ID: <440abda90802211000v64e4a952n63f17808d2b46159@mail.gmail.com>
Date: Thu, 21 Feb 2008 11:00:41 -0700
From: "David Baird" <dhbaird@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: TLB Miss booting linux kernel on ppc 405
In-Reply-To: <5ee408090802210950t498b9752meab2b91d2a13191c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5ee408090802130850w130ce09an507ca5c4d41cc5a8@mail.gmail.com>
	<440abda90802130951h7a23743asc85454bf089c7e55@mail.gmail.com>
	<5ee408090802131003m4b8e632cu931769bc77f9b439@mail.gmail.com>
	<440abda90802131032l6e11eef7gbd7eb57352c2ce4@mail.gmail.com>
	<5ee408090802131049u652ef867wff034b4ccb1067f1@mail.gmail.com>
	<440abda90802131102q234e870fx2cbf12fb3119fd0a@mail.gmail.com>
	<1203542646.4812.38.camel@PisteOff>
	<5ee408090802201329hdb78359m3a60e987a799f06b@mail.gmail.com>
	<440abda90802201347w3945c53dhf47ffd0380aa01aa@mail.gmail.com>
	<5ee408090802210950t498b9752meab2b91d2a13191c@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 21, 2008 at 10:50 AM, Ricardo Ayres Severo
<severo.ricardo@gmail.com> wrote:
>  I rebuilt the design in EDK 9.2i and problem persisted. The only
>  difference is the registers are not zeroing anymore. No exception is
>  thrown, and the system still hangs at memset_io. I'm running out of
>  options.
>  It is possible to boot Linux on Virtex-II, isn't?

Yes, it is possible.  I have a Virtex-II Pro with Linux running on it
although I didn't configure it myself (it is one of those Black Dog
computers).  I work with Virtex-4s right now.

Can you try a reference design for the Virtex-II perhaps?

Can you comment out memset_io and write your own version of it (which
you can insert debug statements into)?

When/where in memset are things breaking?  What is the nature of the
breaking?  Can you get your serial terminal to print out hex values
(for memory locations, memory values, etc.)?
