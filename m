Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 824C0DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Jan 2007 02:49:03 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so2108344ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 04 Jan 2007 07:49:01 -0800 (PST)
Message-ID: <528646bc0701040749w1890cedcg7efd879b36963b06@mail.gmail.com>
Date: Thu, 4 Jan 2007 08:49:01 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David Gamez Alari" <dgalari@gmail.com>
Subject: Re: boot problem in a LITE5200B
In-Reply-To: <3184691b0701040331m5bc79cc3vb749f868e252426b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <3184691b0701040331m5bc79cc3vb749f868e252426b@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/4/07, David Gamez Alari <dgalari@gmail.com> wrote:
> Hello, I have a LITE5200B board and I have a problem when I load the
> kernel and the root filesystem image.
>
> In my screen the LITE5200B board post:
>
> => bootm 0x300000 0x700000
> ## Booting image at 00300000 ...
<snip>
> Serial: MPC52xx PSC driver
> ttyPSC0 at MMIO 0xf0002000 (irq = 40) is a MPC52xx PSC
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> mice: PS/2 mouse device common for all mice
> RAMDISK: Couldn't find valid RAM disk image starting at 0.
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
>  <0>Rebooting in 180 seconds..

What format is your rootfs in?  ext2?  You probably don't have the
needed filesystem driver compiled into the kernel.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
