Message-Id: <v03010d01b361fdd7ad04@[209.96.179.238]>
In-Reply-To: <926564685.4037.ezmlm@lists.yellowdoglinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 14 May 1999 12:32:16 -0400
To: yellowdog-general-help@lists.yellowdoglinux.com,
        linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
Subject: Getting JDK 1.2 to work under glibc 2.1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

As my last act before I move my family to Canada and spend all of my time
packing and unpacking, I was trying to get a glibc 2.1 version of JDK 1.2
available for release.  Since linuxppc R5 has no cd yet, I bought the
yellowdog linux distribution and installed it on my home machine.

I was able to get JDK 1.2 to build under glibc 2.1 using this distribution,
but every time I try to invoke the JVM it seg-faults.  The seg-faults occur
inside glibc 2.1 (in stderr@@GLIBC2.0) during linking.  It seems whenever
the linker can't find a symbol it seems to end is a seg-fault?  Is this a
known problem?

FWIW, this same code works perfectly under glibc 1.99 (Gary's) and works
fine under glibc 2.1 on Linux x86 (or so I am told).

This is with glibc 2.1-1a.ppc.rpm that comes with the yellowdog glibc 2.1
cd distribution.

Is this a known problem with glibc 2.1? Is this a ppc specific problem?

What is the most up-to-date glibc 2.1 rpm that I can use to build with?

Will any JDK 1.2 which works with Yellow Dog Linux work with Linux PPC R5?

I don't have much time and I want to get something out (JDK wise) in the
next week or so if possible before I have to pack my machines up.

Thanks for any help or guidance.

Kevin



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
