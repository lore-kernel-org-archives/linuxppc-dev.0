From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 14 Oct 2003 09:07:07 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ethan Benson <erbenson@alaska.net>,
	LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Time precision, adjtime(x) vs. gettimeofday
Message-ID: <20031014070707.GA8972@iram.es>
References: <20031011004541.5eda8953.billfink@mindspring.com> <20031011052716.GB24569@plato.local.lan> <1065884293.682.27.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1065884293.682.27.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Oct 11, 2003 at 04:58:14PM +0200, Benjamin Herrenschmidt wrote:
>
> > > Assuming the fix works, is there a simple way to test for the
> > > quickserver G4 model rather than doing the "#if 0", since I like to
> > > run a common kernel across a variety of different processor models.
> >
> > i don't know, ive discussed it with benh, but he won't accept that VIA
> > is a better choice here.
>
> Hrm... I do accept that it's a better choice, but I'm sure using
> the KeyLargo timer is even better :) Anyway, I'll switch to VIA by
> default on "PowerMac3,5" type machines for now.

How does the Keylargo timer work? Any pointer?

Also for these machines it seems that OF also returns wrong values.
Maybe there is an OF update somewhere.

Does anybody know what MacOS X (most MacOS X machines probably use
ntp) do?

Sorry, more questions than answers. It superficially looks
like a HW screw-up in one specific series of machines.

	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
