From: bob@kunk.jriver.com
Message-ID: <20000803032548.2702.qmail@kunk.jriver.com>
Subject: Ethernet problem on 7200
To: linuxppc-dev@lists.linuxppc.org
Date: Wed, 2 Aug 2000 22:25:48 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


For some unknown reason, I had trouble getting this message to post. Here
is is without the Re: in it. It is related to a number of problems I
and other uses have been having with mace and 53c94 drivers on various
PowerMac 7200's.


> It's been my experience with several machines that the mace driver doesn't
> work most of the time on the 7200.
>
> Not sure why. The stats are useless. I've tried it with the built-in
> RJ45 and with the AAUI to TP transceiver as well. I'm pretty certain it
> isn't a duplex problem. It appears to be dropping incoming packets.
>
> Only thing you can do (other than fix it ;) is to put in a PCI ethernet
> card. I can tell you that most any tulip (21xxx) based card will work as
> well as the ne2k-pci clones (realtek, etc chips).
>
> It a bummer for me as I'm out of slots and I need to add a decent scsi card.
>
> The 53c94 scsi driver appears to have serious problems on the 7200 as well.
> I can't even write a CD at 1x with it without the fifo emptying even
> with a big buffer and less than 50 megs of data! It looks like it
> may not be doing disconnects properly, the raw speed is OK when testing
> with iozone it's only about 40% slower than a controller in the
> PCI slot. However when it has to wait for the CDwriter to do something
> that doesn't return right away, it just appears to hang the machine.
> Eventually it comes back when the writer is finished (i.e. fixating).
> (no it's not the cable).
>
> If I take out one of the ethernet cards and put in a 2940 I can write at 4x
> without the buffer getting less than 98% full!!! Heck, my 68k performa
> can write at 4x in MacOs.
>
> I've tried this with a bunch of kernels and am currently running the
> 2.2.17pre7 version.


Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
