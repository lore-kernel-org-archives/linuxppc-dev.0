Return-Path: <glikely@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.198])
	by ozlabs.org (Postfix) with ESMTP id BF56F68152
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Aug 2005 09:06:40 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id b11so614246rne
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Aug 2005 16:06:38 -0700 (PDT)
Date: Thu, 25 Aug 2005 17:02:56 -0600
To: T Ziomek <ctz001@email.mot.com>
Message-ID: <20050825230256.GA6497@siegfried.thelikelysolution.ca>
References: <20050824134404.B1DF668108@ozlabs.org>
	<EDFB2B1ED0A1D7118A0A00065BF2490D1E3A601B@il06exm13>
	<20050825062425.GA5607@siegfried.thelikelysolution.ca>
	<Pine.WNT.4.61.0508251610280.2688@holyoke.labs.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.WNT.4.61.0508251610280.2688@holyoke.labs.mot.com>
From: Grant Likely <glikely@gmail.com>
Cc: T Ziomek <Tom.Ziomek@motorola.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Source of xparameter_ml300.h
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 25, 2005 at 05:17:16PM -0500, T Ziomek wrote:
> On Thu, 25 Aug 2005, Grant Likely wrote:
> >On Wed, Aug 24, 2005 at 08:20:48PM -0500, T Ziomek wrote:
> >>
> >>Also, be aware that the differences between 'xparameters.h' and
> >>'xparameters_ml300.h' are not all you need to worry about.
> 
> BTW, I took a approach different from MV's for 'xparameters.h'.  Seeing no
> reason why that file *had* to be changed for Linux (and because the folks
> doing the Xilinx hardware releases I use only use the 'standalone' BSP and
> hence never run that Tcl script), I instead added a 'linux.xparameters.h'
> file.  This file first includes 'xparameters.h' and then #defs all of the
> Linux-specific stuff.
>    Then I changed all Linux #includes of 'xparameters.h' to pull in my new
> file instead.
> 
> My 'linux.xparameters.h' hasn't changed since I created it Feb. 2, though
> I've worked with a dozen or more 'xparameters.h' files in that time.
> 
> IMO, this two files approach is better all-around, with better separation
> of concerns and no Tcl script.
Yes!  My opinion exactly.  I'm doing pretty close to the same thing.  

> 
> [Lots of really great info snipped]
>
> >Thank's for the heads up.  Your email addr's getting a permanent place
> >in my address book.  :)
> 
> :-(
:P

> 
> Just kidding; I've been meaning for months now to put this stuff out on the
> maillist (partly because I'm way overdue on "giving back" and partly to see
> if I was missing some obvious Easy Way).
I'm going to be off work for the next 13 weeks (hooray!) on parental
leave.  In that time I plan to get a bunch of this stuff cleaned up and
submitted to mainline.  If you send me your patches then I'll get them
included in my tree.  If it's too big to email then I'll setup a
location that you can scp it to.

That way we can both get credit
s/credit/blaimed/

:)

> [Lots more really great stuff snipped]
> 
> That's it, for now.
> Tom
You rock!  Thanks for the help.  I'm particularly interested in seeing
you linux.xparameters.h.

Cheers,
g.
