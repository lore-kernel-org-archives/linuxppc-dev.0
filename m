Subject: Re: Bare bones filesytem using Karim's book
In-Reply-To: <20030603151233.92CABC5492@atlas.denx.de>
To: Wolfgang Denk <wd@denx.de>
Date: Tue, 3 Jun 2003 10:50:23 -0600 (MDT)
Cc: brian.auld@adic.com, linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030603165023.460CB27D97@chuy.ouraynet.com>
From: craig@hollabaugh.com (Dr. Craig Hollabaugh)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Also, the approach to strip  down  a  general  purppose  distribution
> (even  an embedded one) does not make much sense - as I wrote before,
> you better design your system bottom up by  starting  with  an  empty
> filesystem  and  just  adding  the  really required components. Where
> "required" means "required to perform some task you defined  in  your
> project specification".


I agree, here's how you start. After kernel initializes everything it
executes init, so what libraries does init require?

holla@gibson[502]: ldd /sbin/init
        libc.so.6 => /lib/libc.so.6 (0x4001a000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)

Well that is if you're running init and want libc. ldd bash, sash,
ash, busybox whatever.

Craig


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
