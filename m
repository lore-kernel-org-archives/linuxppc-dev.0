Date: Fri, 21 Apr 2000 14:22:19 -0700
From: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Subject: Re: Re : does'nt work BWG3v2's ide
To: linuxppc-dev@lists.linuxppc.org
Message-id: <3900C68B.BC46AFB5@dana.ucc.nau.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <38ffabf0395f2339@antholoma.wanadoo.fr> <3900AA7F.A1AA19EE@home.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Robert Shaw wrote:

> No, I get the same problems. I can only get the stable tree to run on my Rev.1 B&W
> G3. I always get IDE problems with the 2.3.x series kernel. I'm glad it's not me,
> but I still have no idea how to get it working right .... :P
>

Speaking of problems with IDE in the 2.3.x kernel.  I've got a problem with it too.
I compiled the current devel version, with the nvram patch in.  At boot, it
recognizes the drive, then gives this error:

partition check:
    /dev/ide/host0/bus0/target0/lun0: hda lost interrupt

Back to the lost interrupts....

I'm trying to build one of the stable kernels now.  We'll see how that goes.

Tim


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
