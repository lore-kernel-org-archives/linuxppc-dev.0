Message-ID: <3ACE1256.2000200@brocade.com>
Date: Fri, 06 Apr 2001 12:00:38 -0700
From: Amit D Chaudhary <amitc@brocade.com>
MIME-Version: 1.0
To: Masahide Tomita <tomita@itl.nyc.co.jp>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: What init in initrd shold do when booting?
References: <200104060124.KAA08060@itl.nyc.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

PSB,

Masahide Tomita wrote:

> Hi,
>
> So, the real quation is how can I mount regular storage (I mean block devices) from init?
As you would mount normally, add the corresponding entries to /etc/fstab
and your rc* scripts will mount them

>What should the init program should do to maount other devices and free the unused memory?

What is the unsued memory you are refering to? The one used by initrd?
In which case doing a umount /initrd should do, though using blockdev
command to flushbuffers on /dev/ram0 is advised.

Amit


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
