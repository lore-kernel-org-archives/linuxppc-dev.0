Message-ID: <374456FE.F3AD5501@wanadoo.fr>
Date: Thu, 20 May 1999 20:39:58 +0200
From: Martin Costabel <costabel@wanadoo.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: OF booting news
References: <XFMail.990520104212.R.Post@sara.nl> <374440FF.D74A6407@americasm01.nt.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jerry Quinn wrote:
> 
> Remco Post wrote:

> > BootX is a huge improvement if you like waiting for a machine to boot and have
> > an option. Quik is still my favourite since I never boot MacOS on my 7200.

> BootX is a huge improvement because it allows OS choice in a clean
> manner. I don't like waiting for my system to boot any more than the
> next person, although timeout on an OS chooser doesn't bother me.

I am curious: Has anyone ever compared the actual booting times for OF
booting and BootX booting (I can't, because my 6400 doesn't OF boot
anymore). I suspect the difference is less than 10 seconds. On a total
booting time of more than 60 seconds, this is really minimal.

I just rebooted, and the total time of 110 seconds (from typing "reboot"
until the login prompt) was spent as follows:

35 sec: shutdown
23 sec: starting MacOS and BootX extension, hitting the button, waiting
for the  
        penguin to show up and the kernel messages to start scrolling by
52 sec: rest of linux boot procedure.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
