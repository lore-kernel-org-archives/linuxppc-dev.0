Subject: Re: ADS860 - unable to load kernel- Bad magic number
From: Bob Beck <beck@assurtech.com>
To: mgroeger@sysgo.com
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.56.0402271730001.24044@mag.sysgo.com>
References: <Iq959772845498.03218@webmail1.inner-21cn.com>
	 <1077816291.4242.6.camel@budweiser>
	 <Pine.LNX.4.56.0402271730001.24044@mag.sysgo.com>
Content-Type: text/plain
Message-Id: <1077834132.4625.2.camel@budweiser>
Mime-Version: 1.0
Date: 27 Feb 2004 12:22:12 +1400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, 2004-02-28 at 06:32, Marius Groeger wrote:
> On Thu, 27 Feb 2004, Bob Beck wrote:
>
> >  What is the difference between vmlinux and zImage.embedded ?
>
> vmlinux is the plain kernel ELF image. You can use it to analyse the kernel
> code or symbols, but you cannot boot it as-is.
>
> zImage.embedded is the compressed kernel image plus some glue code used as a
> bridge between the firmware and the kernel.
>

On my proprietary board (PPC 603). I do not have access to flash
so I am loading vmlinux into RAM and jumping to 0x10000. It is
running into problems in mmu_off.

Should I be loading zImage.embedded instead ?

Bob

I can see
> Regards,
> Marius


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
