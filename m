Message-ID: <000f01c0d75f$5ae07ba0$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Dan Malek" <dan@mvista.com>
Cc: "Wolfgang Denk" <wd@denx.de>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <001d01c0d5c8$27ae8c60$8021690a@huawei.com> <3AF6F323.7944F695@mvista.com>
Subject: Re: Uncompress Ok, but cannot run linux kernel...
Date: Tue, 8 May 2001 09:36:50 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> machael thailer wrote:
> > ..... But I met
> > some urgent problems ...
> >     I modified the bootloader codes according to arch/ppc/mbxboot/head.S
>
> For starters, you shouldn't be using this "boot loader" for a 750.....
> How did you configure a kernel to get there in the first place?
> A 750 should be a CHRP (or PReP, if you have to.....), which will
> direct you to a working "chrpboot" boot loader.

Yes, I choose "6xx/7xx/74xx/8260" and "/PowerMac/PRep/MTX/CHRP" when
configuring the kernel.
Now I find that something is wrong with my serial output codes. When I fix
it , I can trace into arch/ppc/kernel/head.S now.
But it hangs after running "turn_on_mmu". That is to say, it should be able
to run "start_here" (but it cannot .)
By the way , I find that "initial_bats" do 2 different branches according to
whether PVR is 601 or 604. I don't know which branch will 750 do?

Thank you very much.

machael


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
