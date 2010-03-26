Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f217.google.com (mail-gx0-f217.google.com
	[209.85.217.217]) by ozlabs.org (Postfix) with ESMTP id 0D05CB7CEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Mar 2010 09:44:57 +1100 (EST)
Received: by gxk9 with SMTP id 9so197604gxk.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Mar 2010 15:44:56 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100326221707.GA1953@leila.ping.de>
References: <20100317051521.GA16826@feather>
	<fa686aa41003261122s7c03244bm2ffc3347263af613@mail.gmail.com>
	<20100326213202.GD5350@feather> <20100326221707.GA1953@leila.ping.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 26 Mar 2010 16:44:32 -0600
Message-ID: <fa686aa41003261544l5b1a4690xeba4df841c6143d6@mail.gmail.com>
Subject: Re: Failing to get DMA working with MPC5200 (TQM5200) and
	CompactFlash
To: Wolfgang Wegner <wolfgang@leila.ping.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Josh Triplett <josh@joshtriplett.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 26, 2010 at 4:17 PM, Wolfgang Wegner <wolfgang@leila.ping.de> w=
rote:
> Hi Josh,
>
> On Fri, Mar 26, 2010 at 02:32:02PM -0700, Josh Triplett wrote:
>> On Fri, Mar 26, 2010 at 12:22:32PM -0600, Grant Likely wrote:
>> >
>> > Not all CF adapters have all the pins wired up that are needed for
>> > *DMA modes. =A0That is the most likely problem.
>>
>> True, but we bought a card that specifically advertises support for
>> UDMA, and says UDMA right on the card's label.
>>
>> http://store.lexar.com/?productid=3DCF8GB-300-381
>
> Grant was referring to the adapter, not the card!
>
> In fact I still have to see a single CF-to-IDE adapter that does
> have the wires needed for (U)DMA without me soldering them in place...

I found one at logic supply a while back, but I can't remember which one!

g.
