Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2CC77DDF29
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 07:30:33 +1000 (EST)
Date: Thu, 6 Sep 2007 16:30:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 8/9] 8xx: Adder 875 support
Message-ID: <20070906213023.GA6399@ld0162-tx32.am.freescale.net>
References: <85281ec227e35a9e466e68e3fdc7e6ef@kernel.crashing.org>
	<20070906141620.GB16353@ld0162-tx32.am.freescale.net>
	<f26578467468e38345e795ea5f1f7c42@kernel.crashing.org>
	<20070906180922.GA18750@ld0162-tx32.am.freescale.net>
	<598e0baf0dc1ca63b91f2a80ec8abe19@kernel.crashing.org>
	<20070906191255.GA22663@ld0162-tx32.am.freescale.net>
	<20070906192025.GA22775@ld0162-tx32.am.freescale.net>
	<43ad9218d498e2d01922a57ebfee2327@kernel.crashing.org>
	<20070906195614.GA23333@ld0162-tx32.am.freescale.net>
	<143f0a1c76539260fd41fe953e6d1bdf@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <143f0a1c76539260fd41fe953e6d1bdf@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 10:57:28PM +0200, Segher Boessenkool wrote:
> >>>BTW, IEEE1275 seems to disagree:
> >>
> >>No it doesn't.
> >
> >"...in conventional usage the string begins with the name of the 
> >device's
> >manufacturer".
> 
> You cut that sentence short here, it continues: "as with the name
> property."

You ignored the next sentence, which addressed exactly that point.

> >Even if you want to quibble about the manner in which the
> >manufacturer is specified, that's quite different from leaving it out.
> 
> The text of the standard says that often people start the model
> property contents with an "XYZ,".  It doesn't say that is required
> (though it hints it might be a good idea to do so).  It doesn't say
> it is okay to just put some arbitrary text there.

It says exactly that.  They used so many words like "generally",
"arbitrary", "no standard interpretation", "conventional usage", "might",
"for instance", "manufacturer-dependent", etc. that it's fairly clear
that they're merely providing hints as to how the property might be used.

> >>That would be "0ABCDEF,Adder MPC875" or "VWXYZ,Adder MPC875" --
> >>not "some random string without a comma Adder MPC875".
> >
> >"the text string is arbitrary" and "conventional usage".
> 
> It doesn't say that.  It says _the format_ is arbitrary, it is
> quite specific about the contents: model name and number.

"A manufacturer-dependent string that *generally* specifies the model
name and number".

Besides, that's what I did specify, plus the manufacturer.

> >That "random string" is more useful for the intended purpose than the
> >first half of a MAC address.
> 
> What, an OUI isn't useful for uniquely identifying a manufacturer?
> That's news to me.

Not for human consumption.

> >>i.e., it is machine readable.
> >
> >No, it *can* be machine usable in certain circumstances.  I'm 100% sure
> >that there is no code out there that cares what's in the model field of
> >this board's device tree,
> 
> Why would that matter?

It matters because machine consumption is obviously not how this
particular model property is being used.

> >other than to pass it to /proc/cpuinfo (i.e.
> >human consumption).
> 
> It's not my fault that /proc/cpuinfo uses strings that are meant for
> machine consumption by directly showing them to the user, without some
> level of massaging by the platform code first.  It definitely is no
> argument for doing bad things in your device tree now, instead of
> fixing the kernel code.

I am not going to add some completely useless layer of indirection
because it suits your odd interpretation of the standard.  The
/proc/cpuinfo output of the model property is useful.  Descriptive model
properties are useful.  Deal with it.

> Anyway, I've said enough about this, I think I've made my point --
> and this is very minor stuff after all.

Whatever, you brought it up.

-Scott
