Subject: Re: Time precision, adjtime(x) vs. gettimeofday
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan Benson <erbenson@alaska.net>
Cc: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031011052716.GB24569@plato.local.lan>
References: <20031011004541.5eda8953.billfink@mindspring.com>
	 <20031011052716.GB24569@plato.local.lan>
Content-Type: text/plain
Message-Id: <1065884293.682.27.camel@gaston>
Mime-Version: 1.0
Date: Sat, 11 Oct 2003 16:58:14 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Assuming the fix works, is there a simple way to test for the
> > quickserver G4 model rather than doing the "#if 0", since I like to
> > run a common kernel across a variety of different processor models.
>
> i don't know, ive discussed it with benh, but he won't accept that VIA
> is a better choice here.

Hrm... I do accept that it's a better choice, but I'm sure using
the KeyLargo timer is even better :) Anyway, I'll switch to VIA by
default on "PowerMac3,5" type machines for now.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
