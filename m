To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: libc-alpha@sources.redhat.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC] IPC64 with glibc-2.2 and linux-2.4
References: <00092421504403.01070@enzo.bigblue.local>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
From: Ulrich Drepper <drepper@redhat.com>
Date: 24 Sep 2000 23:51:26 -0700
In-Reply-To: Franz Sirl's message of "Sun, 24 Sep 2000 21:50:44 +0200"
Message-ID: <m3u2b5nevl.fsf@otr.mynet.cygnus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl <Franz.Sirl-kernel@lauterbach.com> writes:

> I'm especially interested in:
> - did I get the alignment and data types right everywhere? also right for
> PPC64?
> - I would like to bump ipc64_perm.seq to 32bit as it is internally in
> linux-2.4. Is this safe for userspace? Why didn't the other archs bump it to
> the kernels size?
> - other comments?

The patch looks reasonable to me but I cannot decide about using it
since the kernel would have to be changed first.

--
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
