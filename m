Subject: Re: ADS860 - unable to load kernel- Bad magic number
From: Bob Beck <beck@assurtech.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: m.venkatraj@exgate.tek.com
In-Reply-To: <Iq959772845498.03218@webmail1.inner-21cn.com>
References: <Iq959772845498.03218@webmail1.inner-21cn.com>
Content-Type: text/plain
Message-Id: <1077816291.4242.6.camel@budweiser>
Mime-Version: 1.0
Date: 27 Feb 2004 07:24:51 +1400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-02-27 at 21:45, li wrote:
>
> which kernel image did you download into the target via tftp?
> vmlinux.gz is just gzip version of vmlinux Here i downloaded
> zImage.embedded, which has the following features: ELF 32-bit MSB
> executable, PowerPC or cisco 4500, version 1 (SYSV), staticlly linked,
> not stripped. then, with the offset 0x10000 from loadaddr, the kernel
> is up.

 What is the difference between vmlinux and zImage.embedded ?

Bob

> > I am a linux-newbie working on a parallel track on the MPC 860, on
> > a ADS board. I am facing difficulty in getting the kernel to load.
> > This is what I have done so far:
> >
> > - built a cross-toolchain using Dan Kegel's crosstool.
> > - built u-boot-1.0.1 and flashed it to the board using BDI2000
> > - built linus-2.4.22, (with the below mentioned patch on last attempt).
> >
> > The compilation goes through fine, I get "vmlinux" on the top-dir,
> > and also a vmlinux.gz in the arch/ppc/boot/images if I do a "make
> > zImage".
> >
> > When I configure bootp, and bootup the board, u-boot comes up fine,
> > the tftp download of the kernel image goes through fine too. Then I
> > am stuck with a "Bad Magic Number". Some initial digup led me to a
> > mismatched image header magic number.
> >
> > Could anyone please help me with how to go ahead? Am I missing
> > something?
> >
> > Also thanks to everyone whose postings on this and other lists
> > helped me get started!
> >
> > -----Original Message-----
> > From: Xavier Miville [mailto:xmiville@oerlikon.ca]
> > Sent: Thursday, February 26, 2004 9:58 PM
> > Subject: RE: PCI daughter card with USB on a 405GP
> >
> > You will need to apply the corresponding linuxppc patch
> > (/pub/linux/kernel/ports/ppc/2.4) to 2.4.22. The zvmlinux doesn't seem
> > to be built with only 2.4.22.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
