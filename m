Message-ID: <D73A25AA6E54D511AD74009027B1110F04EC3D@ORION>
From: Ken Applebaum <applebaumk@embeddedplanet.com>
To: yooth@ipone.co.kr, "'Brad Parker'" <brad@parker.boston.ma.us>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Starting usb in RPXlite(mpx850) board 
Date: Mon, 2 Jul 2001 09:42:45 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


we are in the process of building some boards with the B2 parts.

does anyone have any experience on the DE processors? like(s) dislike(s)?

ken

> ----------
> From: 	Brad Parker
> Sent: 	Monday, July 2, 2001 6:22 AM
> To: 	yooth@ipone.co.kr
> Cc: 	linuxppc-embedded
> Subject: 	Re: Starting usb in RPXlite(mpx850) board
>
>
> "Yoo. Jonghoon" wrote:
> >
> >I'm using Montavista Hardhat linux 2.0(kernel 2.4.3) on
> >RPXlite board(mpx850). It uses Brad's HCI driver
> >(m8xxhci.c)
> >
> >At first, hci driver does not wanted to be initialized. I looked
> >inside source codes and found that
> >m8xxhci_start_controller returns error if partnum of cpu is
> >not m823. So I skipped partnum checking routine and then
> >hci drvier initialized. Is there any problem to do this ?
>
> yes!  Older mask revs simply won't work.
>
> If you are using an 850 and it's not a "B2" part, it will not
> work.
>
> I have an update driver I am about to release which includes better
> root hub support and lots of bug fixes.
>
> -brad
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
