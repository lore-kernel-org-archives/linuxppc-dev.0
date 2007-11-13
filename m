Return-Path: <jonsmirl@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.225])
	by ozlabs.org (Postfix) with ESMTP id 2DEDEDDDF7
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 10:53:46 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1334657nzh
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 15:53:45 -0800 (PST)
Message-ID: <9e4733910711131553ked87330ubc0c439c42e51ace@mail.gmail.com>
Date: Tue, 13 Nov 2007 18:53:44 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: Hardware debuggers for PPC74xx G4 CPUs
In-Reply-To: <20071113233906.GA32689@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071113214845.85820@gmx.net>
	<fa686aa40711131357r6b072f4cgcd43c5cb8e73abdb@mail.gmail.com>
	<fa686aa40711131359l43f289e7j48b0df3ff57ea7c7@mail.gmail.com>
	<FA44C867-4933-40F2-8EBA-5C9967005223@embeddedalley.com>
	<20071113233906.GA32689@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/13/07, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Nov 13, 2007 at 03:23:29PM -0800, Dan Malek wrote:
> >
> > On Nov 13, 2007, at 1:59 PM, Grant Likely wrote:
> >
> > >> Abatron BDI-2000.
> > >
> > > Oops, but that's not all that cheap.  ($2750USD).
> >
> > If you place any value on your time or development
> > schedule, it's a bargain.
>
> That only applies for cases where time means money, i.e. professional
> work. Spending three thousand dollars to debug a board that you spent
> a few hundred dollars buying just for a hobby is pretty crazy.

That's why Dominic wants to get OpenOCD running on the PowerPC. All we
need is the programming documentation for controlling the CPU via the
debug hardware.

Obviously this documentation exist, all of the commercial vendors had
to have it to develop their debuggers. Maybe it is already out there
and we just don't know where to look.

-- 
Jon Smirl
jonsmirl@gmail.com
