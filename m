Message-ID: <38F315A7.AF8E0949@embeddededge.com>
Date: Tue, 11 Apr 2000 08:08:07 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
CC: Pavel Roskin <pavel_roskin@geocities.com>,
        "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>,
        "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Software Emulation Exception...
References: <Pine.LNX.4.21.0004071011570.19406-100000@sunapee.transcept.com> <38EE0267.FB881499@embeddededge.com> <kfywvm6s3dz.fsf@kieraypc01.p.y.ki.era.ericsson.se> <38F200CF.B4A07187@embeddededge.com> <kfysnwtrpgn.fsf@kieraypc01.p.y.ki.era.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:

> .... It has a 100% chance of crashing without the patch, and a 0%
> chance of crashing with it.

I agree the patch is necessary to fix a problem managing dirty
pages......


> All you have to do to experience the problem is allocate memory
> until the RAM gets low

....but this wasn't the test....


> .... If you are running a dynamicly linked glibc2
> app what is most likely to happen is that the (dirty) jump table
> is thrown out by the broken MM code.


If, if, if......Is this really what is happening?  I am concerned about
proving a real problem and fixing it.  If you aren't, that's OK.  I
have other things to do.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
