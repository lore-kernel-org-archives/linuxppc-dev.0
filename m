Date: Mon, 14 Jun 1999 20:00:16 -0400 (EDT)
From: Claude Robitaille <root@videotron.ca>
cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: cache line size (was Help booting MBX through bootd)
In-Reply-To: <376501C2.FAF2B207@switchboard.ericsson.se>
Message-ID: <Pine.LNX.4.10.9906141947170.2444-100000@modemcable220.93-200-24.mtl.mc.videotron.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 14 Jun 1999, Magnus Damm wrote:

> 
> budget   core: 850/823 - 8/8 TLBs, 2/1 Kbyte cache.
> standard core: 860/821 - 32/32 TLBs, 4/4 Kbyte cache.
> deluxe   core: 860P    - 32/32 TLBs, 16/8 Kbyte cache
> 
> All seem to have 4 words a 32 bits in each cache line.
> 
> What about the other cpus; 60x, 750/740?
> And the other embedded ones; 8240/8260?
> 
> 8 words a 32 bits in each cache line? 
> 
the 82x0 are based on the 603 and therefore have 32 bytes cache
lines.

BTW, there is a 603 variant that do not have floating
point capability, so the discussion about FP support will
also apply to it (and to the 8260, the 8240 has FP
support).

Claude


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
