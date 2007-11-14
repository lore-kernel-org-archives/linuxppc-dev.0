Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id E8BF6DDDD6
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 12:32:58 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so22377wag
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 17:32:57 -0800 (PST)
Message-ID: <9e4733910711131732i5ec5d226r4037e42399c38f59@mail.gmail.com>
Date: Tue, 13 Nov 2007 20:32:56 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: Hardware debuggers for PPC74xx G4 CPUs
In-Reply-To: <1195003078.28865.18.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071113214845.85820@gmx.net>
	<fa686aa40711131357r6b072f4cgcd43c5cb8e73abdb@mail.gmail.com>
	<fa686aa40711131359l43f289e7j48b0df3ff57ea7c7@mail.gmail.com>
	<FA44C867-4933-40F2-8EBA-5C9967005223@embeddedalley.com>
	<20071113233906.GA32689@lixom.net>
	<9e4733910711131553ked87330ubc0c439c42e51ace@mail.gmail.com>
	<1195003078.28865.18.camel@pasglop>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/13/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > That's why Dominic wants to get OpenOCD running on the PowerPC. All we
> > need is the programming documentation for controlling the CPU via the
> > debug hardware.
>
> Note that this is basically different for every CPU around.

I'd like to get it for the MPC5200 because of the project I am working
on, an open source audio device. It would be nice if there was a cheap
hardware debugger available for hackers to use on it. Maybe one of the
Freescale developers will see this and send me the right docs.

Is it radically different? Dominic has been able to support every ARM
7/9 chip he can get his hands on without too much trouble once the
core support was written. I don't think he has ARM 11 working yet.

>
> > Obviously this documentation exist, all of the commercial vendors had
> > to have it to develop their debuggers. Maybe it is already out there
> > and we just don't know where to look.
>
> Ben.
>
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
