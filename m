Date: Fri, 3 Sep 1999 10:53:25 -0500 (CDT)
From: Grant Erickson <erick205@tc.umn.edu>
To: Dan Malek <dmalek@jlc.net>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: GLIBC wont compile for MPC860
In-Reply-To: <37CFEDCD.ACA47B7C@jlc.net>
Message-Id: <Pine.SOL.4.10.9909031049370.20882-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 3 Sep 1999, Dan Malek wrote:
> Marcus Sundberg wrote:
> > Yes definitely. I intend to submit some patches as soon.....
> 
> Thank you.  This was discussed years ago when we first started
> the 8xx port, but nothing was ever done in the old libraries.
> I just used to make the couple of changes in the code and compile
> with the -mcpu=860 flag and post the binaries on the server.

I'd rather see the patches in sooner than later. At present, I'm playing
around with the IBM 403GCX and there seem to be a large number of
similarities between the issues faced by the 8XX community and those faced
by the 40X community.

> That has been on and off for a long time as well.  It is there
> to specifically support the 8xx (and now 8260) using standard
> distribution libraries.  I am just now porting that kernel version
> to the 8xx, so we'll see how it works....

Hopefully, I'll get a chance to run it against the 403 as well when I get
to that point.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
