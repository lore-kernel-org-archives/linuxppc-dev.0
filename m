Date: Tue, 2 Apr 2002 21:22:22 +0100
Subject: Re: any problems with gcc 3.0/3.1 and compiling 2.4.18 on ppc?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
Cc: linuxppc-dev@lists.linuxppc.org
To: Chris Friesen <cfriesen@nortelnetworks.com>
From: Andrew Bradley <andrew-bradley@ntlworld.com>
In-Reply-To: <3CAA0F4D.26C3A8BC@nortelnetworks.com>
Message-Id: <56A4AB3C-4677-11D6-8E25-0030654F879C@ntlworld.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Chris,

I recently built the  2.4.18+patch kernel (patch details where on
http://www.penguinppc.org/) using "gcc version 2.95.3 20010319 (2.95.4
CVS + prerelease/franzo/20010912)" with out a hitch.
But my main goal is to use g++ 3.x as my default compiler to mimic GCC
3.0.2 on my solaris and linux systems I be using since November.
I tried  (http://www.suse.com/~aj/gcc30.html) and found that there seems
to be an intermittent crash with the compiler.

I also tried building many of the snap shots. My last try was
gcc-20020318.
The Intermittent crashes sometimes go a way when I retry.
stage1/xgcc -Bstage1/ -B/usr/local/powerpc-unknown-linux-gnu/bin/ -c
-DIN_GCC    -g -O2 -W -Wall -Wwrite-strings -Wstrict-prototypes
-Wmissing-prototypes -Wtradi
../../gcc-20020318/gcc/expmed.c: In function `expand_mult':
../../gcc-20020318/gcc/expmed.c:2574: internal error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.
make[2]: *** [expmed.o] Error 1
make[2]: Leaving directory `/root/snap_shot/config/gcc'
make[1]: *** [stage2_build] Error 2
make[1]: Leaving directory `/root/snap_shot/config/gcc'
make: *** [bootstrap] Error 2

I also tried downloading code sourcery's snap shots at
http://www.codesourcery.com/gcc_binary_snapshots.
The gcc-20020318 was incomplete.

Kaoru Fuki said he has "Newer binutils,glibc,gcc from cvs branch"
http://lists.linuxppc.org/linuxppc-user/200203/msg00125.html.
But his ftp seems to be down at:- ftp://sv5.linet.gr.jp/pub/PPC/

I am building on a Suse 7.3 (Mac8500 with G3 upgrade card).

I would appreciate finding other who have successfully built using GCC
3.0 on Apple Hardware. Most people seem to build it with a cross
compiler.

Regards
Andrew

On Tuesday, April 2, 2002, at 09:06  pm, Chris Friesen wrote:

>
> We're looking at moving to gcc 3.x for 2.4.18, and are trying to decide
> what
> version to use.  It appears that there were some ppc-specific fixes
> that went in
> to 3.1, and I'm not sure if they were ported back to 3.0.
>
> Has anyone had any successes or failures using either of these versions
> on
> 2.4.18 on ppc?
> Any gotchas?
>
> Thanks,
>
> Chris
>
>
> PS. Please cc me on replies, as I'm not subscribed to the list at the
> moment.
>
>
> --
> Chris Friesen                    | MailStop: 043/33/F10
> Nortel Networks                  | work: (613) 765-0557
> 3500 Carling Avenue              | fax:  (613) 765-2986
> Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
