Subject: Re: ssh on ppc 405gp?
From: Dave Strout <dstrout@linuxfoundary.com>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030520132322.D67E0C6162@atlas.denx.de>
References: <20030520132322.D67E0C6162@atlas.denx.de>
Content-Type: text/plain
Date: 20 May 2003 09:34:59 -0400
Message-Id: <1053437700.20954.30.camel@dstrout.nsw.enterasys.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well, I can run tcpdump on either interface with no issues, so I'm
pretty sure everything is running OK.  In fact, I can tcpdump on the ppc
box for port 22 while I try it, and all the tcp checksums are OK, so I
don't think it's at the hardware / driver layer.

I'll go through and add some debugging code to see where / what is wrong
with the packets.

thanks,
dave.

On Tue, 2003-05-20 at 09:23, Wolfgang Denk wrote:
> In message <1053434650.21004.7.camel@dstrout.nsw.enterasys.com> you wrote:
> >
> > Thanks for the lead.  I've actually tried that, and I get:
> > Disconnecting: Corrupted check bytes on input.
>
> Are you absolutely sure that your network interface (and the rest  of
> the  system, like RAM) is working correctly? This looks somewhat like
> data corruption...
>
> Best regards,
>
> Wolfgang Denk
>


--
Dave Strout

dstrout@linuxfoundary.com    301/869-0818(h)  240/731-2727(c)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
