Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id D143ADDEC2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 06:31:59 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so371845anc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 05 Sep 2007 13:31:58 -0700 (PDT)
Message-ID: <fa686aa40709051331q4a733c2dha6d182adb5778c83@mail.gmail.com>
Date: Wed, 5 Sep 2007 14:31:58 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Robert Woodworth" <rwoodworth@securics.com>
Subject: Re: Xilinx FX60
In-Reply-To: <1189023628.6185.59.camel@PisteOff>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1189017748.6185.49.camel@PisteOff>
	<200709052342.34177.temerkhanov@yandex.ru>
	<1189023628.6185.59.camel@PisteOff>
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

On 9/5/07, Robert Woodworth <rwoodworth@securics.com> wrote:
> > > Has anyone built a kernel for a dual core PPC Virtex?  I have found very
> > > little docs on how to architect software for the dual-core PPC's.
> > > Will SMP Linux work on this platform?  What would the bus setup be?
> >
> > It won't. There is no hardware cache coherency on Virtex.
> >
> >
>
> Is it then possible to run two independent kernels, one on each PPC??

Absolutely.

Cheers
g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
