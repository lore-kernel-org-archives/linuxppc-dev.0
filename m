Message-Id: <v03010d00b3629a8caf7e@[209.96.179.218]>
In-Reply-To: <99051420024100.00761@ns1102.munich.netsurf.de>
References: <v03010d01b361fdd7ad04@[209.96.179.238]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 14 May 1999 23:36:11 -0400
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev@lists.linuxppc.org, Tom Rini <tmrini@ntplx.net>,
        yellowdog-general@lists.yellowdoglinux.com
From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
Subject: Re: Getting JDK 1.2 to work under glibc 2.1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Tom and Franz,

>get the just released stuff from DRR1, the usual packages, they will install
>nicely on YDL:
>binutils*
>egcs*
>libstdc++*
>cpp*
>glibc*
>nscd*

Thanks!  I upgraded the tool chain to DRR1 and that did the trick.  So I
now have JDK 1.2 up and running under glibc 2.1.  I still have alot of
testing to do of both Motif 2.1 and the JDK but I think I am pretty much
there.

Hi Everyone,

What I need now is a volunteer using glibc 2.1 to put the JDK 1.2 through
its paces and test it as completely as they can.  My home machine is
isolated and I have run the usual few tests I have access to, but I would
really like someone to put it through the ringer under glibc 2.1 and let me
know how it holds up.

If anyone is truly interested and has the time over the next week or so to
pound on it, I would be happy to privately post a beta version for them to
test (please only if interested and serious about testing).  Once it has
been tested, I will make a formal release (hopefully by the end of next
week).

Thanks,

Kevin



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
