Message-ID: <3BF411A7.4000500@amberdata.demon.co.uk>
Date: Thu, 15 Nov 2001 19:04:07 +0000
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: Robert E Brose II <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: E15 Carolina Frame Buffer Driver for 2.4
References: <20011114041633.4910.qmail@kunk.jriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Robert E Brose II wrote:

> One caution:
>
[..]
>
> A big difference between the ibm_e15 fb driver running on 2.4 as opposed
> to 2.2 is that this code that tries to get the frame buffer base address
> succeeds in 2.4 but failed (and was hacked to a "default address") in
> 2.2.


There's a really good reason why 2.4 kernels don't need the hack which
maps it to the default; 2.4 kernels will assign PCI BARs which weren't
set up by the firmware. This code should be removed completely in the
2.4 version.


Cheers,


	David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
