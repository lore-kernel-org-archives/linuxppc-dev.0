Date: Fri, 27 Feb 2004 18:29:27 +0100 (CET)
From: Marius Groeger <mgroeger@sysgo.com>
To: Bob Beck <beck@assurtech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ADS860 - unable to load kernel- Bad magic number
In-Reply-To: <1077834132.4625.2.camel@budweiser>
Message-ID: <Pine.LNX.4.56.0402271825410.24183@mag.sysgo.com>
References: <Iq959772845498.03218@webmail1.inner-21cn.com>
 <1077816291.4242.6.camel@budweiser>  <Pine.LNX.4.56.0402271730001.24044@mag.sysgo.com>
 <1077834132.4625.2.camel@budweiser>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 27 Feb 2004, Bob Beck wrote:

> On Sat, 2004-02-28 at 06:32, Marius Groeger wrote:
> > On Thu, 27 Feb 2004, Bob Beck wrote:
> >
> > >  What is the difference between vmlinux and zImage.embedded ?
> >
> > vmlinux is the plain kernel ELF image. You can use it to analyse the kernel
> > code or symbols, but you cannot boot it as-is.
> >
> > zImage.embedded is the compressed kernel image plus some glue code used as a
> > bridge between the firmware and the kernel.
> >
>
> On my proprietary board (PPC 603). I do not have access to flash
> so I am loading vmlinux into RAM and jumping to 0x10000. It is
> running into problems in mmu_off.
>
> Should I be loading zImage.embedded instead ?

Yes you can try that, but then you will have to modify the code in
arch/ppc/boot/... to match the specifics of your board.

Another popular way to go is to port u-boot to your platform first.
U-boot accepts kernel pImages which you get by doing a "make pImage"
in the kernel source dir.

You will have to know your tools and hardware quite well either way,
be prepared to learn a lot.

Good Luck,
Marius

--
Marius Groeger <mgroeger@sysgo.com>
Project Manager

SYSGO Real-Time Solutions AG | Embedded and Real-Time Software
Am Pfaffenstein 14
55270 Klein-Winternheim, Germany

Voice: +49-6136-9948-0 | FAX: +49-6136-9948-10
www.sysgo.com | www.elinos.com | www.osek.de

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
