In-Reply-To: <762A181C0D966E459A2EB3B810142C7703861518@nmrusdunsx12.nmrlan.net>
References: <762A181C0D966E459A2EB3B810142C7703861518@nmrusdunsx12.nmrlan.net>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <75D875A6-DC05-11D8-9220-003065F9B7DC@embeddededge.com>
Cc: "'Robert P. J. Day'" <rpjday@mindspring.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: random ramblings on 8xx patches (long and tedious :-)
Date: Thu, 22 Jul 2004 13:35:01 -0400
To: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 22, 2004, at 1:10 PM, Wells, Charles wrote:

> ....... The real problem is that the
> MPC850 USB controller was designed for target-mode applications and not
> host-mode applications.  Host-mode in the MPC850 is, at best, an
> after-thought.

That's true.  Having been a part of the early development of all of the
8xx
parts, there were lots of requirements that changed once the parts "hit
the street."


> 0. The MPC850 USB controller is neither of the popular USB 1.1
> implementation models (UHCI or OHCI).

It's not the only one.  I think there are more embedded controllers that
are not UHCI/OHCI than those that are.  Since we work in the source
code world, it hasn't really been much of a problem.

> ..... I haven't timed it, but I suspect the microcode patch
> has trouble meeting this spec. as well.  It does get a whole lot
> closer than
> a software-only solution, though.

The microcode patch works quite well.

> There's a bunch of other detailed problems that I won't bore everyone
> with.
> Bottom line: Don't expect too much out of the MPC850 USB controller in
> host-mode.

There are Linux versions of software that work fine in many
applications.
USB in general doesn't rate high on my list of engineering successes.
I'm never surprised when I plug something in to any kind of system
and it doesn't work.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
