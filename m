Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) by ozlabs.org (Postfix) with ESMTP id 3FA63B7D1D
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 06:28:04 +1000 (EST)
Received: by pwj6 with SMTP id 6so1384651pwj.15
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 13:28:02 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1272362955.24542.24.camel@pasglop>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 27 Apr 2010 14:27:42 -0600
Message-ID: <j2pfa686aa41004271327v1658e33bgd170ecc9735f285b@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for ALSA SoC
	drivers
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 27, 2010 at 4:09 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2010-04-27 at 10:54 +0100, Mark Brown wrote:
>> I'd just like to add that I *really* want to see you guys come to some
>> sort of firm and documented conclusion about the way to handle
>> situations like this. =A0Some variant of this seems to come up every
>> single time anyone tries to do anything to do with audio on a system
>> using the device tree and it's getting really repetitive. =A0What would =
be
>> really useful for audio at this point would be if we could get some sort
>> of decision about how to represent this stuff which we can point people
>> at so that work on systems using the device tree can be done without
>> having to deal with the device tree layout discussions that frequently
>> seem to be involved.

Yes, you're right.  I completely agree.

[...]
> Keep in mind that it's perfectly kosher to create nodes for "virtual"
> devices. IE. We could imagine a node for the "sound subsystem" that
> doesn't actually correspond to any physical device but contain the
> necessary properties that binds everything together. You could even have
> multiple of these if you have separate set of sound HW that aren't
> directly dependant.
>
> I don't have bandwidth to contribute much in this discussion right now,
> at least not to lead it, so I'm happy to let others do so, but I'm happy
> to provide feedback from my own experience as proposals are made.

Unfortunately, I'm in the same boat.  :-(  However, I'll be at UDS in
2 weeks time, and I know audio is a big concern for the Ubuntu folks.
A bunch of the ARM vendors will be there too.  I'll schedule a session
to talk about audio bindings and hopefully that way make some headway
on defining a binding that makes sense and is actually useful.

g.
