Message-ID: <3C9ABB8D.9050408@embeddededge.com>
Date: Fri, 22 Mar 2002 00:05:17 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jeremy Rosen <Jeremy.Rosen@au.thalesgroup.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: m8xx power management
References: <sc9b235b.074@gw_tms_syd2.pty.tms.thomson-csf.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jeremy Rosen wrote:

> before I start working on it... did anybody try to implement the m8xx
> power management under linux ??

You could maybe play with some doze modes at idle, but the bigger challenge
is with parts on the board outside of the processor.  All of the internal
peripherals enter a low power mode when they aren't enabled, and I think
all of the drivers do the right thing.

If you are thinking of a real power-off mode with memory in self-refresh,
well, you have lots of work ahead of you :-).  I would actually measure the
sleep mode power of the processor and ensure it is worth the effort.  It's
a static design that requires very little power to maintain state.

Have fun!


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
