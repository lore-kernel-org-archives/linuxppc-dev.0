From: kd@flaga.is
Subject: Re: Help about the libc-2.1.1 segmentation fault
To: "Shuangjun Zhu" <r44089@email.sps.mot.com>
Cc: linuxppc-embedded@lists.linuxppc.org, lucsch@adaptivemicro.com
Message-ID: <OF55168A45.6BD8B83A-ON002568DD.00395AAB@flaga.is>
Date: Fri, 12 May 2000 10:33:28 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If you want to go the glibc2.1.x route stick with x=3. It is the one giving
the least problems and has stable pthread support for the powerpc. The
pthread support was somehow flaky both for x=1 and x=2 (in my experience).
Just dont forget to apply the necessary patches (Cacheline size patch and
fpu patch) and dont to forget to remove the memset.S file!!!!

I also have been playing with diffrent libraries (although now I am just
using glibc 2.1.3) and what I did is that installed just couple of
"embedded filesystem" which I could switch between just by changing the
export file for the NFS server. ( I am booting the boards over NFS).

Hope this helps,

K.D.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
