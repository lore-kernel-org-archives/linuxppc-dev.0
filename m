In-Reply-To: <199902090234.TAA26936@mx0-smtp.goodnet.com>
Date: Tue, 9 Feb 1999 14:11:54 +0100
To: Kyle Nesbit <kyle.nesbit@asu.edu>, linuxppc-dev@lists.linuxppc.org
From: BenH <bh40@calva.net>
Subject: Re: L2CR
Message-Id: <19990209141154.002518@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At this URL:

<ftp://ftp.linuxppc.org/development/users/benh/GrabG3CacheSetting.sit>

Is a little application that grabs the current L2CR setting under MacOS
and puts it in BootX prefs, enabling BootX "Set G3 Cache" option. The
L2CR value is then put in the device tree by BootX and retreived later by
the kernel.

You need a recent kernel for this to work (vger 2.2.x or Paul's ones) and
a recent version of BootX too:

<ftp://ftp.linuxppc.org/development/users/benh/BootX_1.0.2b1.sit>

This tools does a big horrible hack to get the L2CR value (thanks again
to Terry Greeniaus for the tips !) so I'm interested in any problem you
may encounter.

If that works, the kernel should print in the boot messages (look at
dmesg) a message like "L2CR overriden (value), backside cache is enabled\n"


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
