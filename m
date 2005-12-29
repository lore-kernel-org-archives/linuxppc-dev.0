Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1776B68910
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Dec 2005 23:15:00 +1100 (EST)
Message-ID: <43B3D3F2.6060708@grandegger.com>
Date: Thu, 29 Dec 2005 13:17:54 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Alessandro Rubini <rubini@gnudd.com>
References: <43B2A902.3090008@varma-el.com>	<200512271730.28563.david.jander@protonic.nl>	<20051227214949.GA8236@mail.gnudd.com>	<200512281000.12073.david.jander@protonic.nl>
	<20051228150742.GA18401@mail.gnudd.com>
In-Reply-To: <20051228150742.GA18401@mail.gnudd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: david.jander@protonic.nl, r.schwebel@pengutronix.de,
	socket-can@pengutronix.de, Jan Kiszka <jan.kiszka@web.de>,
	linuxppc-embedded@ozlabs.org
Subject: Re: Which CAN driver to port to for PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alessandro Rubini wrote:
>>Robert Schwebel et al have worked socket based CAN (i.e. implement CAN
>>as _net_ dev, not as char)
> 
> 
> That's great. I've always been convinced it is the right way to go.
> I remember I've said so to a friend in March 2002.  Unfortunately,
> I had no time to do it the right way, due to short deadlines and
> tight budget.  I'm happy Robert did it.

FYI, there is also a RTDM/Xenomai based version of the SJA1000 
socket-based CAN driver at 
http://www.rts.uni-hannover.de/mitarbeiter/kiszka/rtaddon/
As RTDM/Xenomai is avaiable for PowerPC as well, it might be an option.

Wolfgang.

> /alessandro
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
