Content-Type: text/plain;
  charset="iso-8859-1"
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Andrew Bradley <andrew-bradley@ntlworld.com>,
	Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: any problems with gcc 3.0/3.1 and compiling 2.4.18 on ppc?
Date: Tue, 2 Apr 2002 22:33:49 +0200
Cc: linuxppc-dev@lists.linuxppc.org
References: <56A4AB3C-4677-11D6-8E25-0030654F879C@ntlworld.com>
In-Reply-To: <56A4AB3C-4677-11D6-8E25-0030654F879C@ntlworld.com>
MIME-Version: 1.0
Message-Id: <200204022233.49023@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday 02 April 2002 22:22, Andrew Bradley wrote:
> Hi Chris,
>
> I recently built the  2.4.18+patch kernel (patch details where on
> http://www.penguinppc.org/) using "gcc version 2.95.3 20010319 (2.95.4
> CVS + prerelease/franzo/20010912)" with out a hitch.
> But my main goal is to use g++ 3.x as my default compiler to mimic GCC
> 3.0.2 on my solaris and linux systems I be using since November.
> I tried  (http://www.suse.com/~aj/gcc30.html) and found that there seems
> to be an intermittent crash with the compiler.
>
> I also tried building many of the snap shots. My last try was
> gcc-20020318.
> The Intermittent crashes sometimes go a way when I retry.
> stage1/xgcc -Bstage1/ -B/usr/local/powerpc-unknown-linux-gnu/bin/ -c
> -DIN_GCC    -g -O2 -W -Wall -Wwrite-strings -Wstrict-prototypes
> -Wmissing-prototypes -Wtradi
> ../../gcc-20020318/gcc/expmed.c: In function `expand_mult':
> ../../gcc-20020318/gcc/expmed.c:2574: internal error: Segmentation fault
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.
> make[2]: *** [expmed.o] Error 1
> make[2]: Leaving directory `/root/snap_shot/config/gcc'
> make[1]: *** [stage2_build] Error 2
> make[1]: Leaving directory `/root/snap_shot/config/gcc'
> make: *** [bootstrap] Error 2

Are you sure you don't have any HW problems here? I'm building the compiler
nearly daily on 2 different machines without such problems.

> I also tried downloading code sourcery's snap shots at
> http://www.codesourcery.com/gcc_binary_snapshots.
> The gcc-20020318 was incomplete.

The build machine had some troubles, should be fixed now.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
