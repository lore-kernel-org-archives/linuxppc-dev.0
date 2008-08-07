Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 1EC19DDFBA
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 11:10:53 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so35662anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Aug 2008 18:10:52 -0700 (PDT)
Message-ID: <fa686aa40808061810h4ecf69bbj4f45082abd85d854@mail.gmail.com>
Date: Wed, 6 Aug 2008 19:10:51 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: hang w/ppc6xx_defconfig related to 'simple-bus' compatible
In-Reply-To: <20080806173547.GD3138@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <F2163BC0-08A2-4C17-AAE7-C37BD0CA66EA@kernel.crashing.org>
	<20080806134128.GA9533@secretlab.ca>
	<20080806173547.GD3138@ld0162-tx32.am.freescale.net>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 6, 2008 at 11:35 AM, Scott Wood <scottwood@freescale.com> wrote:
> On Wed, Aug 06, 2008 at 07:41:28AM -0600, Grant Likely wrote:
>> On Tue, Aug 05, 2008 at 08:21:31AM -0500, Kumar Gala wrote:
>> > I'm trying to get the ppc6xx_defconfig booting on any 8641 (74xx/e600)
>> > system.  If I remove the 'simple-bus' compatible from the soc node in
>> > the .dts it works.  Otherwise it hangs at but and looks to be crashed in
>> > the serial driver due to accessing memory at 0.
>> >
>> > I've tried the same .dts (w/'simple-bus') using the
>> > mpc8641_hpcn_defconfig and things work.
>>
>> The Xilinx folks hit something similar.  ns16550 nodes get matched if
>> the parent claims simple-bus.  If extra stuff needs to be done to use
>> that port, then bad things happen.
>
> If extra stuff needs to be done, it shouldn't claim to be a simple-bus.

Heh, no, not the bus.  :-)  Extra stuff to use the serial device.

g.
