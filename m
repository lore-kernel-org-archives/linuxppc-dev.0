Message-ID: <37934F1C.3AC97178@msoe.edu>
Date: Mon, 19 Jul 1999 11:15:24 -0500
From: ian reinhart geiser <geiseri@msoe.edu>
MIME-Version: 1.0
To: Simon Piette <spiette@generation.net>
CC: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SANE
References: <37934682.4119BEDF@generation.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Simon Piette wrote:

> Hi,
>
> I've try to use SANE on R5. It compiles flawlessly, but I can get it to
> work. I discussed a lot with Oliver Rauch, a SANE developper (!), and we
> concluded that the problem was either with the scsi generic driver (sg),
> or with the scsi driver (53C94).
>
> I've found two other people unable to use SANE on R5, and I was
> wandering if I could find help in this group to make it work. I can
> provide you with a lot of details, and three testers!
>
> Thanks,
>
> Simon Piette

    i think the problem lies in the way the the scsi bus attaches and
reattaches
    i found that when ever i ran sane my scanner would get a few bytes and
then
    all of my scsi disks would just go into defib.  at this point i was forced
to reboot....

    -ian reinhart geiser


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
