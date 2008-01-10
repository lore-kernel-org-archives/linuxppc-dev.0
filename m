Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 2AF71DE154
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 03:01:05 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so161927anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 08:01:04 -0800 (PST)
Message-ID: <fa686aa40801100801p3da98eecn44401b17fe652da8@mail.gmail.com>
Date: Thu, 10 Jan 2008 09:01:04 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <47863C31.50309@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<20080103235156.GE12883@localhost.localdomain>
	<477EEDFA.9010205@freescale.com>
	<20080106004637.GJ4326@localhost.localdomain>
	<47824AA3.5070808@freescale.com>
	<20080107182853.GA17312@sirena.org.uk>
	<20080110034919.GI17816@localhost.localdomain>
	<9e4733910801092141m5d4476d0l1c081307fd5c1969@mail.gmail.com>
	<1199961015.19903.270.camel@localhost.localdomain>
	<47863C31.50309@freescale.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lg@opensource.wolfsonmicro.com>,
	linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/10/08, Timur Tabi <timur@freescale.com> wrote:
> Liam Girdwood wrote:
>
> > I think we are probably looking at submission in the next 8 - 10 weeks.
> > Currently most of the core code is complete, however some platforms and
> > codecs still need porting.
>
> With that in mind, can I get some kind of consensus from the PPC side as to
> whether this ASoC V1 driver is okay?  I want to get it into 2.6.25.
>
> Keep in mind:
>
> 1) ASoC V1 is not PowerPC-friendly, so it's impossible to make an ASoC V1
> PowerPC driver "100% correct".

The driver doesn't need to be 100% correct.  Drivers are easy to
change if they aren't quite right.  There are no long term
consequences.

However, the device tree issues must be addressed before it is merged
and deployed.  Otherwise we end up having to support poorly designed
trees over the long term.

So, I'm okay with merging the driver *minus* the .dts and
booting-without-of.txt changes.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
