Date: Mon, 31 May 1999 13:43:03 +0200 (CEST)
From: Philipp Tomsich <mac@mars.zserv.tuwien.ac.at>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: OF booting news
In-Reply-To: <374456FE.F3AD5501@wanadoo.fr>
Message-ID: <Pine.LNX.4.03.9905311339270.6986-100000@mars.zserv.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 20 May 1999, Martin Costabel wrote:

> I am curious: Has anyone ever compared the actual booting times for OF
> booting and BootX booting (I can't, because my 6400 doesn't OF boot
> anymore). I suspect the difference is less than 10 seconds. On a total
> booting time of more than 60 seconds, this is really minimal.
> 
> I just rebooted, and the total time of 110 seconds (from typing "reboot"
> until the login prompt) was spent as follows:
> 
> 35 sec: shutdown
> 23 sec: starting MacOS and BootX extension, hitting the button, waiting
> for the  
>         penguin to show up and the kernel messages to start scrolling by
> 52 sec: rest of linux boot procedure.

I upgraded a PowerMac 8500 based PPC target system to YDL-1.0 and
compared the boot times last week. My findings make a rather strong
argument for OF booting: while BootX booting (using MacOS 8.6) takes about
30 secs, the kernel is loaded and started from OF in typically 3 seconds
(stopwatch timing).




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
