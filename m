Date: Fri, 5 Dec 2003 12:53:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: tx_full v.s tx_free race fix in 8xx_io/enet.c?
Message-ID: <20031205195321.GS912@stop.crashing.org>
References: <000201c3ba73$63dba410$0a01a8c0@LUMENTIS02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000201c3ba73$63dba410$0a01a8c0@LUMENTIS02>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Dec 04, 2003 at 03:32:04PM +0100, Joakim Tjernlund wrote:
> > Something I find a bit odd is that I can run ping -s 1472 -f
> > <myTargetIp>
> > without problems, but if i "jump start" the ping with "ping
> > -s 800 -f <myTargetIp> -l 8"
> > I start to loose packages. Ifconfig shows no errors for both cases.
> > Do you get the same?
> >
> >  Jocke
>
> Found this problem. It is the backoff/retry logic thats
> causing very long TX delays. If I reduce "retlim"(retry limit) from
> 15 to 6, the system recovers from a large packet ping storm.
>
> Is it a bad idea to reduce the retry limit?

I don't know, sorry.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
