Message-ID: <39A557AB.C5E516@esd-electronics.com>
Date: Thu, 24 Aug 2000 19:13:15 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: Gary Swanson <gswanson@aminocom.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: usb chipset
References: <39A55C57.4964AA3D@aminocom.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I nearly have the same problem. I need USB support for an PPC405CR
platform ! As far as I know. only PCI USB chipsets (OHCI/UHCI) are
supported by linux. It is also a little problem to get usb host
controller other than PCI chips (I am not sure if you need a masteror
slave chip). But a solution seams to be at the horizont.
The USB host/slave chips from scanlogic (SL11H/S and SL811). I read that
softconnex will write some linux drivers for those chips. But I am sure,
not under the GPL. So it would be nice if someone would do that under
the GPL.

Matthias


Gary Swanson wrote:
>
> Hello,
>
> I hope this isn't an inappropriate newbie question, but here goes.
>
> We have been developing solutions using a PowerPC823, which has on chip
> USB support, but we are starting another development with the PowerPC
> 855, which I understand doesn't have on-chip USB support.
>
> My question is; are there external USB chipsets that we can use that are
> already supported by the 2.2.14 kernel (from the MontaVista CDK 1.2), or
> does anyone have any recommendations for a chipset that would make the
> USB support as straightforward as possible ?
>
> Thank you,
>
> Gary
>

--
-------------------------------------------------
\ Matthias Fuchs                                 \
 \ esd electronic system design Gmbh              \
  \ Vahrenwalder Straﬂe 205                        \
   \ D-30165 Hannover                               \
    \ email: matthias.fuchs@esd-electronics.com      \
     \ phone: +49-511-37298-0                         \
      \ fax:   +49-511-37298-68                        \
       --------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
