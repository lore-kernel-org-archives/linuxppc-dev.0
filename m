From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: linuxppc-dev@lists.linuxppc.org,
        "Kevin B. Hendricks" <kbhend@business.wm.edu>,
        yellowdog-general-help@lists.yellowdoglinux.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Getting JDK 1.2 to work under glibc 2.1
Date: Fri, 14 May 1999 19:54:31 +0200
Content-Type: text/plain
References: <v03010d01b361fdd7ad04@[209.96.179.238]>
MIME-Version: 1.0
Message-Id: <99051420024100.00761@ns1102.munich.netsurf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Fri, 14 May 1999 schrieb Kevin B. Hendricks:
>Hi,
>
>As my last act before I move my family to Canada and spend all of my time
>packing and unpacking, I was trying to get a glibc 2.1 version of JDK 1.2
>available for release.  Since linuxppc R5 has no cd yet, I bought the
>yellowdog linux distribution and installed it on my home machine.
>
>I was able to get JDK 1.2 to build under glibc 2.1 using this distribution,
>but every time I try to invoke the JVM it seg-faults.  The seg-faults occur
>inside glibc 2.1 (in stderr@@GLIBC2.0) during linking.  It seems whenever
>the linker can't find a symbol it seems to end is a seg-fault?  Is this a
>known problem?

Don't remember anything like that.

>FWIW, this same code works perfectly under glibc 1.99 (Gary's) and works
>fine under glibc 2.1 on Linux x86 (or so I am told).
>
>This is with glibc 2.1-1a.ppc.rpm that comes with the yellowdog glibc 2.1
>cd distribution.
>
>Is this a known problem with glibc 2.1? Is this a ppc specific problem?
>
>What is the most up-to-date glibc 2.1 rpm that I can use to build with?
>
>Will any JDK 1.2 which works with Yellow Dog Linux work with Linux PPC R5?

get the just released stuff from DRR1, the usual packages, they will install
nicely on YDL:
binutils*
egcs*
libstdc++*
cpp*
glibc*
nscd*

If this doesn't help, more information on the segfault would be good (I know
it's hard to get it :-( ).

Franz.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
