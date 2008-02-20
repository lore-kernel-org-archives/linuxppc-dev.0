Return-Path: <severo.ricardo@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 59E13DDEFB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 08:29:17 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2722480pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 13:29:16 -0800 (PST)
Message-ID: <5ee408090802201329hdb78359m3a60e987a799f06b@mail.gmail.com>
Date: Wed, 20 Feb 2008 19:29:15 -0200
From: "Ricardo Ayres Severo" <severo.ricardo@gmail.com>
To: "Robert Woodworth" <rwoodworth@securics.com>
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
Cc: David Baird <dhbaird@gmail.com>, linuxppc-embedded@ozlabs.org
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

I didn't solve the problem yet. I'm having problems with the memset_io
in early_init and am studying if the SDRAM is initializing right.
Any progress I'll send to the list.

Good luck,

On Wed, Feb 20, 2008 at 7:24 PM, Robert Woodworth
<rwoodworth@securics.com> wrote:
> Have you solved your problem??
>
>  I'm having the *EXACT* same problem on a Virtex4FX60.
>  The device is configured with PLBv46/MPMC3/LL_TEMAC.
>
>  I'm under the suspicion that the PLB is issuing an error when switching
>  to virtual mode and that there is either a timing/synthesis error or a
>  fundamental error with the way the FPGA is getting synthesized with the
>  PLB.
>
>
>  RJW.
>
>
>
>
>
>  On Wed, 2008-02-13 at 12:02 -0700, David Baird wrote:
>  > On Feb 13, 2008 11:49 AM, Ricardo Ayres Severo <severo.ricardo@gmail.com> wrote:
>  > > Executing without single step the exception doesn't occurs. But at
>  > > __log_buf I get only trash, even after reseting the processor.
>  > > How can I send some characters to uartlite on asm code?
>  >
>  > Great.  This confirms that I am not crazy.  You are having similar
>  > results as I did.  But I still don't yet know why single-step and
>  > memory read can't be used in virtual mode...
>  >
>
>
>
>
> _______________________________________________
>  Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



-- 
Ricardo Ayres Severo <severo.ricardo@gmail.com>
