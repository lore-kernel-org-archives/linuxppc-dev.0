Message-Id: <5.0.0.19.2.20000925110119.01fe1df0@mail.lauterbach.com>
Date: Mon, 25 Sep 2000 11:10:45 +0200
To: drepper@cygnus.com (Ulrich Drepper)
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: [RFC] IPC64 with glibc-2.2 and linux-2.4
Cc: libc-alpha@sources.redhat.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <m3u2b5nevl.fsf@otr.mynet.cygnus.com>
References: <Franz Sirl's message of "Sun, 24 Sep 2000 21:50:44 +0200">
 <00092421504403.01070@enzo.bigblue.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 08:51 25.09.00, Ulrich Drepper wrote:
>Franz Sirl <Franz.Sirl-kernel@lauterbach.com> writes:
>
> > I'm especially interested in:
> > - did I get the alignment and data types right everywhere? also right for
> > PPC64?
> > - I would like to bump ipc64_perm.seq to 32bit as it is internally in
> > linux-2.4. Is this safe for userspace? Why didn't the other archs bump
> it to
> > the kernels size?
> > - other comments?
>
>The patch looks reasonable to me but I cannot decide about using it
>since the kernel would have to be changed first.

Yeah, I know. But it's no problem for me to push this change into the
kernel after some people (including you :-)) have agreed to the principle
of the patch.

What about 'seq'? Can I safely bump it to 32bit for userspace in the final
patch? I see no need for the kernel and userspace being different here, but
all other archs are limiting it to 16bit, so there may be a reason...

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
