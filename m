Message-ID: <3C184765.8050300@embeddededge.com>
Date: Thu, 13 Dec 2001 01:15:01 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Subodh Nijsure <SNijsure@SkyStream.com>
Cc: "'Wolfgang Denk'" <wd@denx.de>,
	Michael Habermann <MHabermann@gmx.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MMU and BDI2000
References: <B25E2E5A003CD311B61E00902778AF2A039C3543@SERVER1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Subodh Nijsure wrote:



> I have kernel 2.4.4 and I do have MMU XLAT and latest BDI firmware from
> Abatron

Can you use a newer kernel that will do all of this for you automatically?

> and I am  not able to get translation to work. I have tried the following

That isn't correct with the latest BDI firmware.  The address at 0xf0 is
not the address of the page table, it is an indirect pointer to an array
of page table root pointers.  Later kernels will set up all of this for you.

We unfortunately had a short-lived version of kernel and BDI2000 that did
use the low address as a pointer to the kernel page tables, but this isn't
done any longer.

Thanks.


-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
