Message-ID: <001301c0d7a6$881cb6a0$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20010508084356.615D42814D@denx.denx.de>
Subject: Re: Uncompress Ok, but cannot run linux kernel... 
Date: Tue, 8 May 2001 18:06:20 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> In message <000b01c0d795$c3e15f80$8021690a@huawei.com> you wrote:
> >
> > > The kernel is loaded with ppcboot and the tftpboot commando. To trace,
I
> > > used mpc8bug.
> ...
> > > I set a breakpoint at the entry of the __start routine. After passing
> > > the turn_on_mmu label, it returns with an rfi and hangs.
> >
> > This is exactly what I meet now.
> > If you have good solutions, please let me know.
>
> Use a debugger that understands the MMU, like the BDI2000 by Abatron.
>
> In any case, make sure the DER does not trap into BDM mode on  normal
> MMU work, i. e. set it to something like 0x2002000F.
>

My board use Powerpc 750. Does 750 has DER?

machael


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
