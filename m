Message-ID: <3D3FCAFF.1030302@esd-electronics.com>
Date: Thu, 25 Jul 2002 11:55:11 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: danieltaylor@acm.org
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [Fwd: Re: How to get rid of unused data in LKM]
References: <3D3FBFBE.9050607@attbi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,

that's a better idea. I think I will do that if there is no way to free
the firmware data from my module.

I found a little code snippet to do kernel file access. It does not seem to be that complicated.

Thanks
Matthias


> Couldn't you do a kernel file open during module_init, store the
> PCI device code and close the file?
>
> Regards,
>
> Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
