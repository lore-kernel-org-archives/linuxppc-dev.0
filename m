Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 998116884E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 04:37:21 +1100 (EST)
To: Nathael PAJANI <nathael.pajani@cpe.fr>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Dec 2005 16:41:03 +0100."
	<438F198F.9020606@cpe.fr>
Date: Thu, 01 Dec 2005 18:37:18 +0100
Sender: wd@denx.de
Message-Id: <20051201173718.C308D353B0C@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8555 8280/8270 USB host support 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <438F198F.9020606@cpe.fr> you wrote:
> 
> If u-boot is the boot loader of your board (the stuff running on it 
> --before-- we see this:
> 
> loaded at:     00400000 005153B4
> board data at: 00513130 00513334
> relocated to:  00405090 00405294
> zimage at:     00405A85 00512099
> avail ram:     00516000 08000000

If U-Boot is your boot load, *and* you see this, than you  made  some
serious  mistake.  U-Boot  is  supposed  to boot the "uImage" images,
which do not issue such messages.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The shortest unit of time in the multiverse is the News York  Second,
defined  as  the  period  of  time between the traffic lights turning
green and the cab behind you honking.
                                - Terry Pratchett, _Lords and Ladies_
