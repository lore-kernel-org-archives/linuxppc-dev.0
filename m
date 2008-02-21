Return-Path: <dhbaird@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 31D58DE031
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Feb 2008 05:04:42 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so123227wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 10:04:41 -0800 (PST)
Message-ID: <440abda90802211004h3833ed00ke1cdc1257e2b0379@mail.gmail.com>
Date: Thu, 21 Feb 2008 11:04:41 -0700
From: "David Baird" <dhbaird@gmail.com>
To: linuxppc-embedded@ozlabs.org, "Robert Woodworth" <rwoodworth@securics.com>
Subject: Re: TLB Miss booting linux kernel on ppc 405
In-Reply-To: <1203542646.4812.38.camel@PisteOff>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5ee408090802130850w130ce09an507ca5c4d41cc5a8@mail.gmail.com>
	<440abda90802130917x79c3c990j6a1fc7c12ba05ed7@mail.gmail.com>
	<5ee408090802130938u7d069636g42a496e489fe5b80@mail.gmail.com>
	<440abda90802130951h7a23743asc85454bf089c7e55@mail.gmail.com>
	<5ee408090802131003m4b8e632cu931769bc77f9b439@mail.gmail.com>
	<440abda90802131032l6e11eef7gbd7eb57352c2ce4@mail.gmail.com>
	<5ee408090802131049u652ef867wff034b4ccb1067f1@mail.gmail.com>
	<440abda90802131102q234e870fx2cbf12fb3119fd0a@mail.gmail.com>
	<1203542646.4812.38.camel@PisteOff>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Robert,

On Wed, Feb 20, 2008 at 2:24 PM, Robert Woodworth
<rwoodworth@securics.com> wrote:
>  I'm under the suspicion that the PLB is issuing an error when switching
>  to virtual mode and that there is either a timing/synthesis error or a
>  fundamental error with the way the FPGA is getting synthesized with the
>  PLB.

Can you offer a suggestion how I can check to see if the PLB is
issuing an error (a good application note for me to read or anything)?
 I was having a similar problem in virtual mode on one of my systems,
and I might be able to see also if I am having a problem with the PLB
bus.

-David
