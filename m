Message-Id: <5.1.0.14.2.20021023003355.02c68428@pop.prodigy.net>
Date: Wed, 23 Oct 2002 00:39:46 -0700
To: "Vishwanath" <vishwanath@mistralsoftware.com>
From: Eugene Surovegin <ebs@innocent.com>
Subject: Re: Monta Vista Linux Supporting Floating Point operations
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <002501c27a66$fcc4bd40$faffa8c0@VISHWANATH>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 12:37 AM 10/23/2002, you wrote:
>I am working on 440GP using Monta Vista Linux 2.1. I need floating point
>operation support (for eg. function sqrt() for calculating square root of
>given float variable) on Linux. I didn't find math emualtion on the Linux.

This is strange.
Floating point emulation IS available in MVL2.1 on 440.
You probably forgot to link with libm.

I just typed trivial test and ran it on our custom 440 board:

main.cpp:
----------------------------------------------
#include <stdio.h>
#include <math.h>

int main(int argc, char* argv[]){

   printf("sqrt(10) = %f\n", sqrt(10.0));

   return 0;
}
----------------------------------------------
Compile and run:

# gcc test.cpp -lm
# ./a.out
sqrt(10) = 3.162278
#

Regards,

  Eugene Surovegin <mailto:ebs@innocent.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
