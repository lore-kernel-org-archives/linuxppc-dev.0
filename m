Date: Mon, 13 Aug 2001 11:40:12 +0200
From: Olaf Hering <olh@suse.de>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: FW: floating point exception problem on apple PPC
Message-ID: <20010813114012.A5473@suse.de>
References: <XFMail.20010807093111.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <XFMail.20010807093111.pochini@shiny.it>; from pochini@shiny.it on Tue, Aug 07, 2001 at 09:31:11AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 07, Giuliano Pochini wrote:


I'm not sure why you got that mail, but there is a bug.

We can sometimes build the current glibc and sometimes it fails with a
FPE in make check. Kernel is a 2.4.7 in that case.

We built it on a pseries 640, 4cpus, 2gig ram. It seems that it does not
occour on a single CPU machine.



Gruss Olaf

> -----FW: <CA256AA1.0019E765.00@d73mta01.au.ibm.com>-----
>
> Date: Tue, 7 Aug 2001 10:10:05 +0530
> Sender: linux-kernel-owner@vger.kernel.org
> From: mdaljeet@in.ibm.com
> To: linux-kernel@vger.kernel.org
> Subject: floating point exception problem on apple PPC
>
> Hi,
>
> I am using SuSE Linux 7.1 with kernel version 2.4.2 on Apple G4 dual
> processor PPC machine.
>
> Due to setting of MSR[FE0] and MSR[FE1] bits in the 'FPUnavailable'
> exception handler, a user application that tries to do floating point
> arthemetic with large floating point values gets a SIGFPE signal. By
> setting the FPSCR register with appropriate value in the SIGFPE signal
> handler the program runs fine with the expected values.
>
> Now, what happens is that when I run such program (that does floating point
> arthemetic with large floating point values) continuously for hours, the
> other applications running on the system sometimes get terminated after
> receiving a SIGFPE signal while my floating point program runs fine. Is
> that due to some kernel problem or loading the FPSCR in the SIGFPE signal
> handler of a process can lead to this problem?
>
> regards,
> Daljeet.
>
>
>
> --------------End of forwarded message-------------------------
>
> Bye.
>
>

--



--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
