From: benh@kernel.crashing.org
To: Paul White <pwhite@bivio.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MPC7455
Date: Wed, 6 Mar 2002 22:48:49 +0100
Message-Id: <20020306214849.11643@mailhost.mipsys.com>
In-Reply-To: 
 <Pine.LNX.4.21.0203062152510.30207-100000@stimpy.networkrobots.com>
References: 
 <Pine.LNX.4.21.0203062152510.30207-100000@stimpy.networkrobots.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Great!  It sounds like the firmware is doing everyhting.  It might be
>nice to add an option to have linux configure the CPU registers or not,
>as for us embedded guys thats easier than implimenting it all in the
>firmware.  We can do it either way now that we know what the registers
>should be, though.

Well, then the correct place for the patch is probably in the wrapper
or in a CONFIG_xxx option for your embedded box. At least for PReP/CHRP/Pmac,
I want to rely on the firmware for various reasons (one beeing that Apple's
firmware sets some bits in specific ways to avoid/workaround chip errata).

>I'll have a cleaned up patch file by tomorrow evening.  What tree
>would you prefer the patch be against?

Whatever, I'll probably edit it anyway.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
