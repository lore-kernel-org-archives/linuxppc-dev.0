Message-ID: <3B3C0ECD.BB633095@mvista.com>
Date: Fri, 29 Jun 2001 01:14:53 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: machael thailer <dony.he@huawei.com>
Cc: karanthk@lycos.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Uncompressing......
References: <BEOODLLCEMKDDCAA@mailcity.com> <001b01c0feb4$6d9dcb40$8021690a@huawei.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


machael thailer wrote:

> The above relocate messages seems to be wrong.

Yes.

> Try to link your kernel at 0x400000, this may solve your problem.

No, they way to solve the problem is to leave the Makefiles and
all of the addresses alone, that is just as they are in the original
sources.  Simply build the zImage, load the image at address 0x200000
and jump to it.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
