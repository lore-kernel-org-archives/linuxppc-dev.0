To: bsimon@ctam.com.au
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
        linux-embedded <linux-embedded@waste.org>
Subject: Re: Building 'mount' for an embedded system
References: <38333C71.3FFD50E@ctam.com.au>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 18 Nov 1999 14:39:29 +0100
In-Reply-To: Brendan Simon's message of "Thu, 18 Nov 1999 10:38:25 +1100"
Message-ID: <kfyiu2z7wby.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brendan Simon <bsimon@ctam.com.au> writes:

> I downloaded linuxppc-pre-R5/sources/base/mount-2.9o-1.src.rpm from a
> LinuxPPC mirror.
> I installed it in a temporary location on my x86 machine and tried to
> compile it with my powerpc-linux cross-compiler.  It would not build as
> there were files missing.
> 
> I read README.mount which said mount was presently maintained by Andries
> Brouwer <aeb@cwi.nl> and the ftp site is ftp.win.tue.nl/pub/linux/util.
> 
> I downloaded
> ftp://ftp.win.tue.nl/pub/linux/utils/util-linux/util-linux-2.10b.tar.gz
> which had some of the missing files but not all of them.
> 
> Can anyone tell me where I can get COMPLETE sources to compile mount for
> a powerpc system (embedded) or at least where I can find the missing
> bits and pieces.

It would help if you told what files are missing.
I built mount from one of the 2.9 versions of util-linux without 
problems.

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
