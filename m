To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: libc-alpha@sources.redhat.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC] IPC64 with glibc-2.2 and linux-2.4
References: <Franz Sirl's message of "Sun, 24 Sep 2000 21:50:44 +0200">
	<00092421504403.01070@enzo.bigblue.local>
	<5.0.0.19.2.20000925110119.01fe1df0@mail.lauterbach.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
From: Ulrich Drepper <drepper@redhat.com>
Date: 25 Sep 2000 08:25:54 -0700
In-Reply-To: Franz Sirl's message of "Mon, 25 Sep 2000 11:10:45 +0200"
Message-ID: <m366nko5ml.fsf@otr.mynet.cygnus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl <Franz.Sirl-kernel@lauterbach.com> writes:

> What about 'seq'? Can I safely bump it to 32bit for userspace in the final
> patch? I see no need for the kernel and userspace being different here, but
> all other archs are limiting it to 16bit, so there may be a reason...

You should avoid changing the size of the struct.  I haven't done the
math on this.

--
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
