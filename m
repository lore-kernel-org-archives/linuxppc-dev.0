Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 1A35268900
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 01:07:05 +1100 (EST)
Date: Thu, 29 Dec 2005 14:43:55 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Andrey Volkov <avolkov@varma-el.com>
Message-ID: <20051229134355.GH19375@pengutronix.de>
References: <200512271730.28563.david.jander@protonic.nl>
	<20051227214949.GA8236@mail.gnudd.com>
	<200512281000.12073.david.jander@protonic.nl>
	<43B2A902.3090008@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <43B2A902.3090008@varma-el.com>
Sender: Robert Schwebel <rsc@pengutronix.de>
Cc: David Jander <david.jander@protonic.nl>, urs.thuermann@volkswagen.de,
	socket-can@pengutronix.de, oliver.hartkopp@volkswagen.de,
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

Hi, 

On Wed, Dec 28, 2005 at 06:02:26PM +0300, Andrey Volkov wrote:
> Robert Schwebel et al have worked socket based CAN (i.e. implement CAN
> as _net_ dev, not as char), as consequence you will not have problem
> with major/minor numbers, duplicated code in drivers for different
> chips, could share CAN dev between diff processes _without_ misc.
> third party shared libraies, stacked CAN protocols (CANopen/NMEA2000
> could be abstract kernel module)... But currently it is not open for
> everyone (due to beta status, AFAIK)
> 
> Alessandro, please check Pengutronix work first, may be it will be
> helpfull to you to
>
> [...]
>
> P.S. Robert, when I check last time, it was mature enogh, so may be time
> to open mail-list and svn?

The socket-can stuff is mature enouth to have been used in some projects
at Pengutronix.

In december, we have made a synchronisation meeting with the VW people
who made the initial port for 2.4; they are more focussed on having
higher level transport protocols ontop of the "raw" socket interface we
currently use. During that process we have reviewed the user interface
with regard to their use cases, so it will have to be changed a little
bit before we have something which is in a state to be posted on lkml.

Unfortunately we have no commercial project behind the infrastructure
work, so it's priority is lower than it should be to really drive things
forward (paying customers have a higher priority than community work). 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
