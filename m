Date: Sat, 9 Aug 2003 13:48:02 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] 2.6 timebase synchronization
Message-ID: <20030809114802.GA1654@ibrium.se>
References: <20030808001523.GA9274@ibrium.se> <20030809011305.GA12030@ibrium.se> <1060419490.653.18.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1060419490.653.18.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Aug 09, 2003 at 10:58:11AM +0200, Benjamin Herrenschmidt wrote:
> I'm on vacation now, I can't test it until I'm back, but that
> looks quite good overall (except maybe the MacOS-like constant
> naming for kXXXX :)
>
> However, does it work with more than 2 CPUs ?

Yes, it does. The code simply passes the timestamp from CPU0
to the one currently beeing booted (the CPU0 timebase is
not affected).

> It seem to be rather
> dual CPU centric from my understanding of the ack mecanism...

Only a pair of CPUs are synchronized simultaneously, yes. But there
is absolutely no need to synchronize more than two at the same.
Besides, CPU2 is not started until CPU1 has booted...

/Samuel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
