In-Reply-To: <199902090234.TAA26936@mx0-smtp.goodnet.com>
Date: Tue, 9 Feb 1999 12:02:08 +0100
To: Kyle Nesbit <kyle.nesbit@asu.edu>, linuxppc-dev@lists.linuxppc.org
From: BenH <bh40@calva.net>
Subject: Re: L2CR
Message-Id: <19990209120208.022074@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The up-to-date l2cr code should be in vger now, we disabled the
command-line option for now (it required changes in non-arch specific
sources, and we wanted to avoid this because of the merge). The l2cr
value can still be passed by BootX using the device-tree. Just open bootx
preferences with resedit, add an "L2CR" resource ID 0 which is 4 bytes
long, and stuff your L2CR value in it. This will enable the "Set G3
cache" option in BootX.

Future version of PowerLogix software may be able to set BootX
Preferences directly. I'll write a tool for capturing MacOS current L2CR
value real soon now.


On Mon, Feb 8, 1999, Kyle Nesbit <kyle.nesbit@asu.edu> wrote:

>I am currently looking for some more info on how to get my L2 backside cache
>running.  I am using a powerlogix card.
>
>I have used the powerlogix/Ben patch posted in the mailing list during Dec.
>The kernel compiled without and error.  When I try to pass the l2cr kernel
>argument I get nothing.  my /proc/sys/kernel/l2cr is 00000000: disabled,
>etc...
>
>Another thing that is strange is in /proc/cpuinfo the clock rate of my chip
>is off by over 100 MHZ.
>
>I would greatly appreciate if someone could point me to more info on the
>subject.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
