Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 9496BB7CF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 28 Mar 2010 04:45:00 +1100 (EST)
To: Josh Triplett <josh@joshtriplett.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Failing to get DMA working with MPC5200 (TQM5200) and CompactFlash
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20100326225916.GA5690@feather>
References: <20100317051521.GA16826@feather>
	<fa686aa41003261122s7c03244bm2ffc3347263af613@mail.gmail.com>
	<20100326213202.GD5350@feather>
	<20100326221707.GA1953@leila.ping.de>
	<20100326225916.GA5690@feather>
Date: Sat, 27 Mar 2010 18:44:55 +0100
Message-Id: <20100327174455.1888CEAD184@gemini.denx.de>
Cc: Wolfgang Wegner <wolfgang@leila.ping.de>, linuxppc-dev@lists.ozlabs.org,
	Andrew Greenberg <andrew@psas.pdx.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Josh Triplett,

In message <20100326225916.GA5690@feather> you wrote:
>
> However, according to one of our hardware hackers, Andrew Greenberg
> (CCed), the STK5200 development breakout board for the TQM5200 *does*
> have the DMA pins wired up correctly, at least according to its
> schematic.  That doesn't guarantee that the board matches the schematic,
> of course.

We tested CF cards for DMA support some time ago, and IIRC this
included the STK5200. Situation was that only very few CF cards
actually support DMA (even if they advertise it on the label).

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I wish Captain Vimes were here. He wouldn't have  known  what  to  do
either, but he's got a much better vocabulary to be baffled in.
                                 - Terry Pratchett, _Guards! Guards!_
