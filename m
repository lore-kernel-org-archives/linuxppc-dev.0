Date: Sun, 24 Oct 1999 10:26:22 -0400 (EDT)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Re: NFS Root - I am further ahead
In-reply-to: <Pine.LNX.4.10.9910231348370.3522-100000@localhost.localdomain>
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9910241018120.5580-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

finally, all I had to do is to had an entry into /etc/hosts
so that mountd's authentication pass.

Now, on the serial console, I see that the root system is
mounted via NFS and that some memory is freed but then the
systerm hangs there. I did some tcpdump while the board is
booting and I found that:

/sbin/init gets loaded
/lib/ld.so.1 -> ld-2.1.1.so gets also loaded

but this all gets loaded, even if /sbin/init needs libc.so.6
and libutil.so.1 (as indicated by ldd). Is it normal that theses
2 libraries does not get loaded immediately after ld.so.1? If it is,
idea why the system hangs?

Thanks

Claude


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
