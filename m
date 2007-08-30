Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 32407DDE09
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 10:29:03 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so66547anc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 17:29:03 -0700 (PDT)
Message-ID: <fa686aa40708291729j3f63a57dl32e5d4df647326b5@mail.gmail.com>
Date: Wed, 29 Aug 2007 18:29:02 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Robert Woodworth" <rwoodworth@securics.com>
Subject: Re: Xilinx Virtex boot
In-Reply-To: <1188430494.8717.26.camel@PisteOff>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1188430494.8717.26.camel@PisteOff>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/29/07, Robert Woodworth <rwoodworth@securics.com> wrote:
> I'm trying to port Linux to a new Virtex Platform.  The kernel will not
> uncompress, I get the following on the console:
>
> loaded at:     00400000 004FB19C
> board data at: 004F9120 004F919C
> relocated to:  00404054 004040D0
> zimage at:     00404E50 004F8409
> avail ram:     004FC000 04000000
>
> Linux/PPC load: console=ttyUL root=/dev/xsa2
> Uncompressing Linux...
> zlib_inflateInit2 returned 00506530
> exit
>
> Any ideas what causes this error??
> Is something mis-configured on my EDK project?
>

Possibly, do you know that EDK has your ram is configured correctly
(ie. have you run a memory test application)?

>
> I have 64MB DDR on the OPB *not* the PLB.
> Is that a problem??

It shouldn't be the problem, but why are you doing that?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
