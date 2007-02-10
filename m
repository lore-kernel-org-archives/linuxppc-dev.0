Return-Path: <dgibson@ozlabs.org>
Date: Sat, 10 Feb 2007 11:42:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: device tree / how to build/compile & use with u-boot to boot
	uImage?
Message-ID: <20070210004211.GB8276@localhost.localdomain>
References: <BD261180E6D35F4D9D32F3E44FD3D901066B2252@EMPBEDEX.empirix.com>
	<528646bc0702091437n2d78124bj34d035e2a7a93ed3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc0702091437n2d78124bj34d035e2a7a93ed3@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, "Morrison,
	Tom" <tmorrison@empirix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 09, 2007 at 03:37:45PM -0700, Grant Likely wrote:
> On 2/9/07, Morrison, Tom <tmorrison@empirix.com> wrote:
> > All,
> >
> > I tried to compile the default dts image (using the dtc compiler
> > installed by LTIB), but it is complaining about no '/chosen' in
> > the definition:
> >
> >   <path>/dtc -I dts -O dtb - -o mpc8548cds.dtb -V 16 dts/mpc8548cds.dts
> 
> Add the -f flag to ignore the warning.  It's bogus for what you're
> doing.

Yeah, I really need to rework dtc's warnings and error messages, it's
much too keen to complain at the moment.  I just haven't had the time,
yet.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
