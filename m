To: "Jon A. Christopher" <jon@amanda.tamu.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: bug in getenv/putenv on linuxppc/G4
References: <Pine.LNX.4.04.9911010157580.7854-200000@amanda.tamu.edu>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 01 Nov 1999 13:55:24 +0100
In-Reply-To: "Jon A. Christopher"'s message of "Mon, 1 Nov 1999 02:02:55 -0600 (EST)"
Message-ID: <kfyd7tuz803.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Jon A. Christopher" <jon@amanda.tamu.edu> writes:

> I've just discovered a bug in either getenv (probably) or putenv (less
> likely) on linuxppc on a G4, glibc-2.1.1-6c.
> 
> The attached test program demonstrates the bug.  Basically, using putenv
> to add a variable to the environment whose name is only one letter long
> and then using getenv to read it doesn't work.  
> 
> Variables with two or more letters are processed as normal.
> 
> I'm not sure if this is a glibc or a linuxppc problem, but I don't have
> teh same problem on my intel RH 5.2 box, or any other unix I've ever heard
> of.

It's a libc problem, reported on the libc-alpha list a few months
ago, and I think a patch was posted too.
It's fixed in glibc 2.1.2 in any case.

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
