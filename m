Message-Id: <200010241533.LAA04867@xor.cs.umd.edu>
To: Chris Leishman <masklin@debian.org>
cc: linuxppc-dev@lists.linuxppc.org, capveg@cs.umd.edu
Subject: Re: airport woes? 
In-reply-to: Your message of "Tue, 24 Oct 2000 15:16:44 +1100."
             <20001024151644.A660@nina.dev.fol>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Oct 2000 11:33:46 -0400
From: Rob <capveg@cs.umd.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I'm using benh's latest kernel and airport driver.  Now I can't think what
>would be causing this, but I thought you'd like to know.  Anyone else seen
>this problem?

I have the above (with the patched pcmcia package), bronze lombard 400mhz, and
everything works for me.  It honestly sounds like a lack of signal problem.
There are a couple of graphical signal strength monitors, or you could do what
I did, and write a stupid shell script (ask me if you want it) to dredge the
signal strength out of /proc.

Hope this helps,

- Rob
.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
