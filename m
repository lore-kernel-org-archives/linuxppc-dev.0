Message-Id: <l03130302b4bc2b80bf95@[213.6.45.224]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 1 Feb 2000 07:20:13 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Moritz Thomas <motho@gmx.net>
Subject: Re: Compilation error during Building Gnustep
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I compiled GNUStep some days ago with gcc 2.95.2 (not from fsirl however),
and it gave me the same error when compiling with optimization. 'twas the
only one, though.

mo

>this bug came up quite some time ago and i believe its fixed now, upgrade
>to gcc 2.95.2 and give it a shot.  you should find all necessary gcc rpms
>in devel.linuxppc.org/users/fsirl/R5/RPMS.
>
>ani
>
>
>On Tue, 25 Jan 2000, Stephane Leon wrote:
>
>>
>> Hi,
>>
>>  I try to install today Gnustep.
>>
>>  I download gstep-core-0.6.0 from gnustep.org.
>>
>>  After ./configure and during make i get :
>>
>>  -I/nowhere/Headers -o
>>  shared_obj/powerpc/linux-gnu/gnu-gnu-gnu/xgps/NSSplitView.o
>>  NSSplitView.m
>>  /usr/src/redhat/BUILD/egcs/1.1.2/gcc/expr.c:570: Internal compiler
>> error
>>  in function convert_move
>>
>>  Is my compiler version ?
>>  I am running Linux ppc kernel 2.2.10.
>>
>>  When i type gcc -v i obtain : reading specs from
>>  /usr/lib/gcc-lib/ppc-redhat-linux/egcs-2.91.66/specs
>>  gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
