Message-ID: <389E4CA7.90331C52@erols.com>
Date: Sun, 06 Feb 2000 23:40:07 -0500
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: beethoven@socal.rr.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Help with ethernet setup on 450 G4.
References: <389B26DA.DE41F422@socal.rr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Richard Young wrote:

> I did the installation from getting FTP files and not from CD so I may
> be missing
>

Okay, if you got the ftp installation working, then there shouldn't be a
problem...

> something. I am using Ben H's kernel 2.2.15.pre3.  Most everything seems
> to be
>

Okay, I have gmac ethernet working w/ BenH's 2.2.15pre3 on a sawtooth...

> working (after some painful updates, not knowing which RPM's hold which
> files
> such as libraries) except for the ethernet stuff.
>

Generally the files correspond...ie if you need libxpm.so.3, it's probably
in the libxpm rpm, or the libxmp-devel rpm or something along those
lines....

> I don't have much of an idea how the ethernet stuff is handled under
> Linux.

Well, most likely transparently to you...that's the ideal anyways :-)

> I get complaints about eth2 not being a device and the like.  Is there a
> conf file
> somewhere that specifies something more about the eth2 device?
> I tried using linuxconf to set it up but the error log also showed
> similar problems
> when trying to run those network scripts.
>

eth2?  Why are you running off of eth2?  Built in ethernet is eth0.  Do you
have a special ethernet card?  Otherwise, you use eth0...

> Is the eth2 support compiled into the kernel or is it supposed to be a
> module or
> something like that? At this point, I'm lost!

It's not that eth2 is a module, it's a device.  eth refers to your network
driver.  Like hdXY refers to partition Y on ide drive X, ethX refers to the
X interface, built in is (AFAIK) generally eth0.

I would go into linuxconf, and make sure that your basic ethernet settings
are for eth0, NOT eth2...

HTH
--Nelson Abramson

--
Shouldn't people be arrested and persecuted for engaging in their
constitutional rights?  http://www.opendvd.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
