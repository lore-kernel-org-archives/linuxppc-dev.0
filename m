In-Reply-To: <199904281818.UAA01127@student.physik.uni-mainz.de>
Date: Thu, 29 Apr 1999 12:41:56 +0200
To: Christian.Bauer@uni-mainz.de
CC: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Endianess problems in linuxppc kernel
Message-Id: <19990429124156.011678@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 28, 1999, Christian Bauer <Christian.Bauer@uni-mainz.de> wrote:

>CC: linuxppc-dev@lists.linuxppc.org
>----------
>
>>Do you know which Apple chip is this, so it can be added to the pciutils
>>database?
>
>The device tree has this to say:
>
>Devices:device-tree:bandit:ohare

This is Ohare, one of the evolutions of Apple's Grand Central. 

Some Device IDs I know are:

0x0002 for Grand Central
0x0007 for Ohare
0x0010 for Heathrow mac-io (PowerBook G3 Series, PowerMac G3s).
0x0017 for Paddington mac-io (iMac, PowerMac G3s).

>Maybe the host bridge also does byte swapping on the frame buffer??

Hum, the bridge is a bandit, I don't think bandit can swap anything. But
you may be using the wrong frame buffer apperture.


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@misys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
