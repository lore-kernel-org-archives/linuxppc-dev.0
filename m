Message-ID: <3B341B5B.2090301@mvista.com>
Date: Fri, 22 Jun 2001 21:30:19 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: yooth@ipone.co.kr
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Starting usb in RPXlite(mpx850) board
References: <NFBBLHGHILCOPCKBODHAEEPHCAAA.yooth@ipone.co.kr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yoo. Jonghoon wrote:

> I'm using Montavista Hardhat linux 2.0(kernel 2.4.3) on
> RPXlite board(mpx850). It uses Brad's HCI driver
> (m8xxhci.c)
>
> At first, hci driver does not wanted to be initialized. I looked
> inside source codes and found that
> m8xxhci_start_controller returns error if partnum of cpu is
> not m823. So I skipped partnum checking routine and then
> hci drvier initialized. Is there any problem to do this ?


uh, I believe so.  If I remember correctly, USB is only supported on the
823 rpxlite DW.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
