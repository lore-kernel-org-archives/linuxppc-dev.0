Message-Id: <v03110701b4edaa5c1f3e@[129.100.29.243]>
In-Reply-To: <v03110701b4eda44b28b7@[129.100.29.243]>
References: <20000309201738.011546@mailhost.mipsys.com>
 <v03110700b4ed3e1295ce@[129.100.29.243]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 9 Mar 2000 14:28:21 -0500
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: IDE problems with 2.3.49?- same with 2.2.15pre3
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

>>>Is there something different about recent G4 450s that I need to worry
>>>about?
>>
>>Use yaboot, not BootX and tell me if you still have the problem.


Nope, all of the booting problems went away with yaboot!

Unfortunately, booting with of is not my choice:

1. Where can I get the yaboot-0.5 version as a MacOS app that can be used
from zip

2.  I do not want to again repartition.  Is booting from a zip using the
o-f keys my only choice now?  Instead of using a zip, could I burn a cd-rom
with yaboot on it that I put in when I want to of boot and then restart and
hold down the c key?  Would it be better to put your of-booting script on
the cdrom?

Also, is there any chance BootX will be fixed to work with these machines
or am I SOL (I spend as much time using MacOS as LinuxPPC and liked the
control of simple dual booting without messing with of).

Thanks!

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
