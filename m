Message-ID: <3EA823A1.7030905@mvista.com>
Date: Thu, 24 Apr 2003 10:49:21 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Kent Borg <kentborg@borg.org>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: boot/simple in ROM?
References: <20030424123313.A8490@borg.org> <3EA81B3F.9080709@embeddededge.com> <20030424133222.B8490@borg.org>
In-Reply-To: <20030424133222.B8490@borg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kent Borg wrote:

>On Thu, Apr 24, 2003 at 01:13:35PM -0400, Dan Malek wrote:
>
>
>>The other really nice thing about these bootloaders, compressed
>>kernels, and attached initrd, is you can boot the identical image
>>from all "devices."  For example, during development you can tftp
>>load the image, get everything working, then place the exact same
>>bits into a flash rom.  Simply jump to the first location of the
>>image and it will boot from flash.
>>
>>
>
>Yes, but disappointingly the ppc/boot/simple I am using (from 2.4
>devel) won't run from ROM.  Is there a better boot loader I should be
>using?
>
>
You're a little sparse on info here but try lopping off the first 64KB
of your zImage (or jump 0x10000 into the zImage that you have).

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
