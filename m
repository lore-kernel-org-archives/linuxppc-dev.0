Message-Id: <5.1.0.14.2.20011116081902.00bc9950@falcon.si.com>
Date: Fri, 16 Nov 2001 08:19:53 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Reading SDRAM Memory Configuration via EEPROM on SIMM
In-Reply-To: <20011115225836.B19227@lx.c-side.com>
References: <200111160524.fAG5OI6U000706@krakatoa.gigabitnetworks.com>
 <200111160524.fAG5OI6U000706@krakatoa.gigabitnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In a URL :-)
   http://developer.intel.com/technology/memory/pc133sdram/spec/spdsd12b.htm

gvb


At 10:58 PM 11/15/01 -0800, Neil Russell wrote:

>Most SDRAM chip specs have enough stuff to figure this out.  I don't
>have an address handy, but if you look at a chip and go to the
>manufacturer's web site, ...
>
>Also, LiMon has some code to do some of the SDRAM stuff.  It is written
>in C, so it won't work on many CPUs, and it doesn't (yet) handle timing;
>just geometry.  (C works on the 8260 before SDRAM is available because
>you can use the internal RAM as a stack.)
>
>         www.thinsys.com/limon.html
>
>
>Neil.
>
>
>On Thu, Nov 15, 2001 at 09:24:18PM -0800, James F Dougherty wrote:
> >
> > Does anyone know how to read an SDRAM SIMM EEPROM
> > to get the memory configuration data? I remember
> > there was a spec for this ... forgot the name...
> >
> > You basically read I2C data bytes from an EEPROM
> > in a standard format.... PC's do this to find memory
> > settings..
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
