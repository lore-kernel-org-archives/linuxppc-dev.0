Message-Id: <4.2.0.58.20000427130443.00acba10@praesum.com>
Date: Thu, 27 Apr 2000 13:08:09 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: Kent Dahlgren <kent@praesum.com>
Subject: Re: Video Card with PowerPC initialization Code
In-Reply-To: <39089B20.D9941BBA@raleigh.ibm.com>
References: <3905A4C9.7C58472E@raleigh.ibm.com>
 <4.2.0.58.20000427124716.00c06bc0@praesum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 03:55 PM 4/27/00 -0400, you wrote:
>Kent,
>
>Which ones?
>
>Chip

Try ATI I believe that the only difference between their Mac and PC video
cards is that the Mac ones have Open Firmware, oh and cost more of course ;-)

         http://www.ati.com

Kent


>Kent Dahlgren wrote:
> >
> > At 08:53 AM 4/26/00 +0200, you wrote:
> >
> > >On Tue, 25 Apr 2000, Ralph Blach wrote:
> > >
> > > > Does anybody know of Video card which has a ROM that has PowerPC
> > > > initializaiton in it?  If so, what is it?
> > >
> > >They don't.
> > >
> > >PowerPC desktop systems usually comes with Open Firmware
> > >(aka. OpenBoot on SPARC) wich requires expansion ROMs to
> > >be in CPU neutral Forth code, compiled runtime.
> > >Hence, VGA BIOS does not apply.
> >
> > Well there are PCI video cards for the Mac that have Open Firmware
> > on them. One of those may do it for you. This of course assumes that
> > you have Open Firmware support on your system. The downside to
> > Open Firmware is of course that it's big, expensive, and there are no
> > open source implementations available AFAIK.
> >
> > Kent
> >
> > _______________________________________________________________
> >
> > Praesum Communications                  Phone: (510) 337-0495
> > Suite 1                                 Fax:   (510) 337-0418
> > 1134E Ballena Blvd                      email: kent@praesum.com
> > Alameda, Ca. 94501                      web:   www.praesum.com
> > _______________________________________________________________
> >

_______________________________________________________________

Praesum Communications                  Phone: (510) 337-0495
Suite 1                                 Fax:   (510) 337-0418
1134E Ballena Blvd                      email: kent@praesum.com
Alameda, Ca. 94501                      web:   www.praesum.com
_______________________________________________________________

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
