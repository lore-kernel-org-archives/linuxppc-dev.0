Subject: Re: Wrong BAT mapping message in dmesg
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Etsushi Kato <ekato@ees.hokudai.ac.jp>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <7DDF51AB-96F9-11D7-8217-00039394E428@ees.hokudai.ac.jp>
References: <7DDF51AB-96F9-11D7-8217-00039394E428@ees.hokudai.ac.jp>
Content-Type: text/plain
Message-Id: <1054798370.700.14.camel@gaston>
Mime-Version: 1.0
Date: 05 Jun 2003 09:32:50 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2003-06-05 at 04:00, Etsushi Kato wrote:
> Hi,
>
> I found a harmless bug in pgtable.c.  My machine has 144MB RAM, but
> dmesg says "Memory BAT mapping: BAT2=128Mb, BAT3=16Mb, residual: 32Mb".
>   It should be "(total_lowmem - __bat2 - __bat3) >>20" for residual,
> isn't it?

Yup, I though I fixed that message, must have missed it...

> Cheers,
>
>
> P.S.
> I recently created Linux-2.4 for NuBus PowerMac repository with
> bitkeeper.  If anyone has interested in this, please look at
> http://nubus-pmac.bkbits.net/.  This nubus tree is originally derived
> from Takashi Oe's 2.4.6-pre3 patch, and I've maintained since
> 2.4.19-something.

Ah great. I was wondering what was the status. What about 2.5 ? Do
you have any intend to go there ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
