Date: Wed, 10 Mar 1999 21:41:41 -0500 (EST)
Message-Id: <199903110241.VAA03544@mail.eclipse.net>
From: Steven Sartorius <ssartor@eclipse.net>
To: <hollis+@andrew.cmu.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: No-IDE kernel compile link errors
Mime-Version: 1.0
Content-Type: text/plain; Charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>When I rerun 'make menuconfig', I find that the IDE stuff has been re-enabled
>on me. My other changes were saved, though. Examining the .config file, I find
>that CONFIG_BLK_DEV_IDE_PMAC and CONFIG_PARIDE_PARPORT are both set to y.

I've had the same problem.  The only way I could get rid of all traces of IDE was to run 'make config' and tediously step through each kernel option.  A pain but it worked.

Steve

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
