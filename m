Date: Mon, 29 Jan 2001 11:24:57 +0000
Subject: Re: correct use of lock_kernel() - help!  please
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Roman Zippel <zippel@fh-brandenburg.de>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010129112448.C96802EFBD@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks Roman,
On  Mon, Jan 29, 2001, Roman Zippel wrote:
> On Mon, 29 Jan 2001, Iain Sandoe wrote:
>> AFACIT we could hold the kernel locked for *several seconds*
> If you sleep inbetween, it's no problem. The kernel lock is released
> automatically during sleep and reget after sleeping.

Ok. I think we are alright then.

>> What do I really need to protect with lock/unlock pairs?
> SMP protection. Only a single processor can hold the kernel lock at the
> same time. The preferred solution is of course to use semaphores /
> spinlocks.

I think my question was badly phrased:

Around the use of which kernel resources should a lock be applied?

tia,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
