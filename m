Message-Id: <199908201732.TAA09408@mail.shiny.it>
To: toa@pop.agri.ch
Subject: Re: MO-Disk on PPC with 53C94 SCSI-chip
Cc: linuxppc-dev@lists.linuxppc.org, x-linux-kernel@vger.rutgers.edu
Date: Thu, 19 Aug 1999 22:45:46 CEST
From: "Giuliano Pochini" <pochini@denise.shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>I have a LinuxPPC R5 system running on a PowerMac 7200 with the
>2.2.12pre8 kernel. 
[...]
>I can create a fs on the partiton, I can read/write from/to it. BUT,
>when I try to change the side of the media I get the same fs tree as 
on
>the first side.

Some removable medias don't tell Linux when you change the disk. The 
easies way to make it work is to try to mount the device before 
reinserting a new disk (you'll get some orrors of course... ignore 
them), so Linux notices you changed it.

>So I tried booting without media in to verify if it works on the clean
>way. This what the dmesg says:

[...]

Strange. I get a "READ CAPACITY failed, blah blah blah", but then all 
works fine.

[PMac 7300, MO Fujitsu 640MB on ext. SCSI bus]

Bye.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
