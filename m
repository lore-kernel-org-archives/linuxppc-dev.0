To: Claude Robitaille <crobitaille@videotron.ca>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS Root - I am further ahead
References: <Pine.LNX.4.10.9910241018120.5580-100000@localhost.localdomain>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 24 Oct 1999 16:49:18 +0200
In-Reply-To: Claude Robitaille's message of "Sun, 24 Oct 1999 10:26:22 -0400 (EDT)"
Message-ID: <kfy66zwstjl.fsf@kieraypc01.p.y.ki.era.ericsson.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Claude Robitaille <crobitaille@videotron.ca> writes:

> Hi,
> 
> finally, all I had to do is to had an entry into /etc/hosts
> so that mountd's authentication pass.
> 
> Now, on the serial console, I see that the root system is
> mounted via NFS and that some memory is freed but then the
> systerm hangs there. I did some tcpdump while the board is
> booting and I found that:
> 
> /sbin/init gets loaded
> /lib/ld.so.1 -> ld-2.1.1.so gets also loaded
> 
> but this all gets loaded, even if /sbin/init needs libc.so.6
> and libutil.so.1 (as indicated by ldd). Is it normal that theses
> 2 libraries does not get loaded immediately after ld.so.1?

They would, unless ld-2.1.1.so crashed.

> If it is, idea why the system hangs?

Sounds like you haven't made the highly needed MPC8xx modifications
to glibc. See the archive of this list.

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
