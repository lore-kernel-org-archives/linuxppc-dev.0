Message-Id: <200107021122.HAA83441@p2.parker.boston.ma.us>
To: yooth@ipone.co.kr
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Starting usb in RPXlite(mpx850) board 
In-reply-to: Your message of "Fri, 22 Jun 2001 18:43:36 +0900."
             <NFBBLHGHILCOPCKBODHAEEPHCAAA.yooth@ipone.co.kr>
Date: Mon, 02 Jul 2001 07:22:15 -0400
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Yoo. Jonghoon" wrote:
>
>I'm using Montavista Hardhat linux 2.0(kernel 2.4.3) on
>RPXlite board(mpx850). It uses Brad's HCI driver
>(m8xxhci.c)
>
>At first, hci driver does not wanted to be initialized. I looked
>inside source codes and found that
>m8xxhci_start_controller returns error if partnum of cpu is
>not m823. So I skipped partnum checking routine and then
>hci drvier initialized. Is there any problem to do this ?

yes!  Older mask revs simply won't work.

If you are using an 850 and it's not a "B2" part, it will not
work.

I have an update driver I am about to release which includes better
root hub support and lots of bug fixes.

-brad


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
