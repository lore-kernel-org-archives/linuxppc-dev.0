Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.232])
	by ozlabs.org (Postfix) with ESMTP id D8CAEDECEC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Apr 2008 02:50:46 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so2808808wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 09:50:45 -0700 (PDT)
Message-ID: <fa686aa40804240950u2dbfe881g330a9828975ba382@mail.gmail.com>
Date: Thu, 24 Apr 2008 10:50:44 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Brian Silverman" <bsilverman@conceptxdesign.com>
Subject: Re: EABI
In-Reply-To: <4810B196.7000300@conceptxdesign.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4810B196.7000300@conceptxdesign.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Apr 24, 2008 at 10:13 AM, Brian Silverman
<bsilverman@conceptxdesign.com> wrote:
>
>
> Is it possible to compile a Linux application using an EABI compiler
> (specfically, Xilinx's EDK powerpc-eabi-gcc.exe)?
>
> The issue at hand is that we'd like for our customers to be able to use the
> Xilinx EDK toolchain (which we know they will have) to compile Linx apps
> without having to install another toolchain (crosstool, ELDK, etc).
>
> So, what I'm hoping is that the EDK toolchain can be configured to be Linux
> compatible binaries, or that there is some kind of wrapper that will handle
> the incompatible interfaces.  Searching around, I've seen some mention of
> Linux EABI compatibility (for Debian ARM releases), but I haven't found any
> clear concensus...
>
>  P.S. My apologies if this message appears on the mailing list twice...

Unfortunately, no.

I recommend making use of the ELDK toolchain from Denx.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
