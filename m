To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: libc-alpha@sources.redhat.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC] IPC64 with glibc-2.2 and linux-2.4
References: <Franz Sirl's message of "Mon, 25 Sep 2000 11:10:45 +0200"> <Franz
	Sirl's message of "Sun, 24 Sep 2000 21:50:44 +0200">
	<00092421504403.01070@enzo.bigblue.local>
	<5.0.0.19.2.20000925110119.01fe1df0@mail.lauterbach.com>
	<5.0.0.19.2.20000925173113.02e31040@mail.lauterbach.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
From: Ulrich Drepper <drepper@redhat.com>
Date: 25 Sep 2000 09:08:37 -0700
In-Reply-To: Franz Sirl's message of "Mon, 25 Sep 2000 17:54:26 +0200"
Message-ID: <m3r968mp2y.fsf@otr.mynet.cygnus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl <Franz.Sirl-kernel@lauterbach.com> writes:

> Well, changing compared to what? IPC_64 on PPC was never functional
> so far, so there is no problem here. The IPC_64 structs on the other
> archs have this, eg on sparc:

I'm failing to see where you want to see ipc_perm64 included in the
compilation environment unless you replace ipc_perm.  There are no LFS
variants for the SysV IPC functions.  And then ipc_perm64 should be
the same size as ipc_perm.

--
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
