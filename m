Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 36AFDDDF59
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 12:09:25 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so304670anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 19:09:24 -0700 (PDT)
Message-ID: <fa686aa40804121909s4ee04731ua63afa76fe088828@mail.gmail.com>
Date: Sat, 12 Apr 2008 20:09:23 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sean MacLennan" <seanm@seanm.ca>
Subject: Re: Warp patches for 2.6.26
In-Reply-To: <20080412215544.38fa2d0b@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080412134831.424480cf@lappy.seanm.ca>
	<20080413104430.c98244d2.sfr@canb.auug.org.au>
	<20080412215544.38fa2d0b@lappy.seanm.ca>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 12, 2008 at 7:55 PM, Sean MacLennan <seanm@seanm.ca> wrote:
> On Sun, 13 Apr 2008 10:44:30 +1000
>  "Stephen Rothwell" <sfr@canb.auug.org.au> wrote:
>
>  > Hi Sean,
>  >
>  > First comment is that you need reasonable changelogs i.e. explain why
>  > you are making changes as well as what they do.  Also the first line
>  > of each changelog (which becomes the subject of any mail generated
>  > from git) should be a useful and relatively unique summary.
>  >
>
>  These patches are an amalgamation of a lot of commits. For
>  example, warp.c was changed 15 times since I last sent a patch to
>  linuxppc-dev. warp-nand.c was probably changed even more as we kept
>  shifting the design.
>
>  One of the advantages of an FPGA based design is you can work around a
>  lot of hardware problems. A disadvantage is that it is easy to change,
>  so it changes a lot. And the HW guys push the specs out to after they
>  actually get the feature going. There is no SW input into the FPGA
>  design.
>
>  So these patches are basically following the changes to the FPGA and
>  changes to the hardware. As new functionality was added, I updated the
>  code.
>
>  Is there a particular way I should word this to make it a changelog?

You can still describe what the code changes; either by itemizing all
the changes; or if it now appears to be a whole new thing, but
describing what it does /now/.  :-)

A changelog of "updates a bunch of stuff" is pretty much irrelevant in
all situations I can think of.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
