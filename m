Date: Mon, 25 Sep 2000 14:24:09 -0700
From: Geoff Keating <geoffk@cygnus.com>
Message-Id: <200009252124.OAA25434@geoffk.org>
To: Franz.Sirl-kernel@lauterbach.com
CC: drepper@cygnus.com, libc-alpha@sources.redhat.com,
        linuxppc-dev@lists.linuxppc.org
In-reply-to: <5.0.0.19.2.20000925110119.01fe1df0@mail.lauterbach.com> (message
	from Franz Sirl on Mon, 25 Sep 2000 11:10:45 +0200)
Subject: Re: [RFC] IPC64 with glibc-2.2 and linux-2.4
References: <Franz Sirl's message of "Sun, 24 Sep 2000 21:50:44 +0200">
 <00092421504403.01070@enzo.bigblue.local> <5.0.0.19.2.20000925110119.01fe1df0@mail.lauterbach.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Date: Mon, 25 Sep 2000 11:10:45 +0200
> From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
> Cc: libc-alpha@sources.redhat.com, linuxppc-dev@lists.linuxppc.org

> Yeah, I know. But it's no problem for me to push this change into the
> kernel after some people (including you :-)) have agreed to the principle
> of the patch.

I too agree with the principle of the patch.  There's no reason to
limit this quantity to 16 bits.

> What about 'seq'? Can I safely bump it to 32bit for userspace in the final
> patch? I see no need for the kernel and userspace being different here, but
> all other archs are limiting it to 16bit, so there may be a reason...

I can't see any particular reason.

Did you test it?  There are four combinations to check:

new application/new kernel
old application/new kernel  (to test symbol versioning)
new application/old kernel  (test translation of old structure to new)
old application/old kernel  (this should Just Work if the above cases work)
			    (but of course you should still check it :-) )

--
- Geoffrey Keating <geoffk@cygnus.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
