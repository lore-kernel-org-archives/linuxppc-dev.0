Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: RE: ssh on ppc 405gp?
From: Dave Strout <dstrout@linuxfoundary.com>
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <C6D44AA99ECEB540A5498F15F92DA07D6886F7@amperion01>
References: <C6D44AA99ECEB540A5498F15F92DA07D6886F7@amperion01>
Content-Type: text/plain
Date: 20 May 2003 08:44:09 -0400
Message-Id: <1053434650.21004.7.camel@dstrout.nsw.enterasys.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jeff,

Thanks for the lead.  I've actually tried that, and I get:
Disconnecting: Corrupted check bytes on input.

I'll keep playing with it.  If anybody has a generated Makefile for
openssl / openssh on the 405, I'd love to see it & see what the
differences are.  I'm thinking it's most likely in my config, given that
there exists at least one working example...

thanks,
dave.

On Tue, 2003-05-20 at 08:26, Jeff David wrote:
>
> I have seen this problem before.  It was happening a few months ago, and
> hasn't happened since!
>
> We use ssh to get to our ppc405h.  The temporary workaround for this
> problem was to use a different mac protocol.  I believe the default is
> 2, so we tried 1, and it worked!  Here's the command:
>
> ssh -1 192.168.25.35
>
> Hope this works for you.
>
> Jeff


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
