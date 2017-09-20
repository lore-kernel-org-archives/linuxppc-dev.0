Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0060.outbound.protection.outlook.com [104.47.37.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xy5G00XvszDqR8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 02:45:26 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "leoyang.li@nxp.com" <leoyang.li@nxp.com>, "york.sun@nxp.com"
 <york.sun@nxp.com>
Subject: Re: Machine Check in P2010(e500v2)
Date: Wed, 20 Sep 2017 16:45:20 +0000
Message-ID: <1505925917.14509.8.camel@infinera.com>
References: <1504265576.20777.61.camel@infinera.com>
 <1504600831.27247.20.camel@infinera.com>
 <VI1PR04MB2078E4FFD1B27961F63D88689A970@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <AM4PR0401MB16992DFADBD59ADEF8E3ACC08F970@AM4PR0401MB1699.eurprd04.prod.outlook.com>
 <1504729020.27247.120.camel@infinera.com>
 <AM4PR0401MB16990A5A3D77ED57C9A645D98F970@AM4PR0401MB1699.eurprd04.prod.outlook.com>
 <1504731221.27247.126.camel@infinera.com>
 <AM4PR0401MB16995FE3651C5F423FBAD2278F970@AM4PR0401MB1699.eurprd04.prod.outlook.com>
 <1504738204.27247.133.camel@infinera.com>
 <1504773676.31322.2.camel@infinera.com>
 <AM4PR0401MB16993C0235EA67562A8B8D4E8F940@AM4PR0401MB1699.eurprd04.prod.outlook.com>
 <1504864463.31322.31.camel@infinera.com>
 <1504875052.31322.38.camel@infinera.com>
 <AM4PR0401MB1699D52CA4E6FB227412D9608F950@AM4PR0401MB1699.eurprd04.prod.outlook.com>
 <1504961140.31322.69.camel@infinera.com>
In-Reply-To: <1504961140.31322.69.camel@infinera.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-09-09 at 14:45 +0200, Joakim Tjernlund wrote:
> On Fri, 2017-09-08 at 22:27 +0000, Leo Li wrote:
> > > -----Original Message-----
> > > From: Joakim Tjernlund [mailto:Joakim.Tjernlund@infinera.com]
> > > Sent: Friday, September 08, 2017 7:51 AM
> > > To: linuxppc-dev@lists.ozlabs.org; Leo Li <leoyang.li@nxp.com>; York =
Sun
> > > <york.sun@nxp.com>
> > > Subject: Re: Machine Check in P2010(e500v2)
> > >=20
> > > On Fri, 2017-09-08 at 11:54 +0200, Joakim Tjernlund wrote:
> > > > On Thu, 2017-09-07 at 18:54 +0000, Leo Li wrote:
> > > > > > -----Original Message-----
> > > > > > From: Joakim Tjernlund [mailto:Joakim.Tjernlund@infinera.com]
> > > > > > Sent: Thursday, September 07, 2017 3:41 AM
> > > > > > To: linuxppc-dev@lists.ozlabs.org; Leo Li <leoyang.li@nxp.com>;
> > > > > > York Sun <york.sun@nxp.com>
> > > > > > Subject: Re: Machine Check in P2010(e500v2)
> > > > > >=20
> > > > > > On Thu, 2017-09-07 at 00:50 +0200, Joakim Tjernlund wrote:
> > > > > > > On Wed, 2017-09-06 at 21:13 +0000, Leo Li wrote:
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Joakim Tjernlund
> > > > > > > > > [mailto:Joakim.Tjernlund@infinera.com]
> > > > > > > > > Sent: Wednesday, September 06, 2017 3:54 PM
> > > > > > > > > To: linuxppc-dev@lists.ozlabs.org; Leo Li
> > > > > > > > > <leoyang.li@nxp.com>; York Sun <york.sun@nxp.com>
> > > > > > > > > Subject: Re: Machine Check in P2010(e500v2)
> > > > > > > > >=20
> > > > > > > > > On Wed, 2017-09-06 at 20:28 +0000, Leo Li wrote:
> > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > From: Joakim Tjernlund
> > > > > > > > > > > [mailto:Joakim.Tjernlund@infinera.com]
> > > > > > > > > > > Sent: Wednesday, September 06, 2017 3:17 PM
> > > > > > > > > > > To: linuxppc-dev@lists.ozlabs.org; Leo Li
> > > > > > > > > > > <leoyang.li@nxp.com>; York Sun <york.sun@nxp.com>
> > > > > > > > > > > Subject: Re: Machine Check in P2010(e500v2)
> > > > > > > > > > >=20
> > > > > > > > > > > On Wed, 2017-09-06 at 19:31 +0000, Leo Li wrote:
> > > > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > > > From: York Sun
> > > > > > > > > > > > > Sent: Wednesday, September 06, 2017 10:38 AM
> > > > > > > > > > > > > To: Joakim Tjernlund
> > > > > > > > > > > > > <Joakim.Tjernlund@infinera.com>;
> > > > > > > > > > > > > linuxppc- dev@lists.ozlabs.org; Leo Li
> > > > > > > > > > > > > <leoyang.li@nxp.com>
> > > > > > > > > > > > > Subject: Re: Machine Check in P2010(e500v2)
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Scott is no longer with Freescale/NXP. Adding Leo=
.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > On 09/05/2017 01:40 AM, Joakim Tjernlund wrote:
> > > > > > > > > > > > > > So after some debugging I found this bug:
> > > > > > > > > > > > > > @@ -996,7 +998,7 @@ int
> > > > > > > > > > > > > > fsl_pci_mcheck_exception(struct pt_regs
> > > > > > > > >=20
> > > > > > > > > *regs)
> > > > > > > > > > > > > >          if (is_in_pci_mem_space(addr)) {
> > > > > > > > > > > > > >                  if (user_mode(regs)) {
> > > > > > > > > > > > > >                          pagefault_disable();
> > > > > > > > > > > > > > -                       ret =3D get_user(regs->=
nip, &inst);
> > > > > > > > > > > > > > +                       ret =3D get_user(inst,
> > > > > > > > > > > > > > + (__u32 __user *)regs->nip);
> > > > > > > > > > > > > >                          pagefault_enable();
> > > > > > > > > > > > > >                  } else {
> > > > > > > > > > > > > >                          ret =3D
> > > > > > > > > > > > > > probe_kernel_address(regs->nip, inst);
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > However, the kernel still locked up after fixin=
g that.
> > > > > > > > > > > > > > Now I wonder why this fixup is there in the fir=
st place?
> > > > > > > > > > > > > > The routine will not really fixup the insn, jus=
t
> > > > > > > > > > > > > > return 0xffffffff for the failing read and then=
 advance the
> > >=20
> > > process NIP.
> > > > > > > > > > > >=20
> > > > > > > > > > > > You are right.  The code here only gives 0xffffffff=
 to
> > > > > > > > > > > > the load instructions and
> > > > > > > > > > >=20
> > > > > > > > > > > continue with the next instruction when the load
> > > > > > > > > > > instruction is causing the machine check.  This will
> > > > > > > > > > > prevent a system lockup when reading from PCI/RapidIO=
 device
> > >=20
> > > which is link down.
> > > > > > > > > > > >=20
> > > > > > > > > > > > I don't know what is actual problem in your case.
> > > > > > > > > > > > Maybe it is a write
> > > > > > > > > > >=20
> > > > > > > > > > > instruction instead of read?   Or the code is in a in=
finite loop
> > >=20
> > > waiting for
> > > > > >=20
> > > > > > a
> > > > > > > > >=20
> > > > > > > > > valid
> > > > > > > > > > > read result?  Are you able to do some further debuggi=
ng
> > > > > > > > > > > with the NIP correctly printed?
> > > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > According to the MC it is a Read and the NIP also lea=
ds
> > > > > > > > > > > to a read in the
> > > > > > > > >=20
> > > > > > > > > program.
> > > > > > > > > > > ATM, I have disabled the fixup but I will enable that=
 again.
> > > > > > > > > > > Question, is it safe add a small printk when this MC
> > > > > > > > > > > happens(after fixing up)? I need to see that it has
> > > > > > > > > > > happened as the error is somewhat
> > > > > > > > >=20
> > > > > > > > > random.
> > > > > > > > > >=20
> > > > > > > > > > I think it is safe to add printk as the current machine
> > > > > > > > > > check handlers are also
> > > > > > > > >=20
> > > > > > > > > using printk.
> > > > > > > > >=20
> > > > > > > > > I hope so, but if the fixup fires there is no printk at a=
ll so I was a bit
> > >=20
> > > unsure.
> > > > > > > > > Don't like this fixup though, is there not a better way t=
han
> > > > > > > > > faking a read to user space(or kernel for that matter) ?
> > > > > > > >=20
> > > > > > > > I don't have a better idea.  Without the fixup, the offendi=
ng
> > > > > > > > load instruction
> > > > > >=20
> > > > > > will never finish if there is anything wrong with the backing
> > > > > > device and freeze the whole system.  Do you have any suggestion=
 in mind?
> > > > > > > >=20
> > > > > > >=20
> > > > > > > But it never finishes the load, it just fakes a load of
> > > > > > > 0xfffffffff, for user space I rather have it signal a SIGBUS =
but
> > > > > > > that does not seem to work either, at least not for us but th=
at
> > > > > > > could be a bug in general MC code
> > > > > >=20
> > > > > > maybe.
> > > > > > > This fixup might be valid for kernel only as it has never wor=
ked
> > > > > > > for user space
> > > > > >=20
> > > > > > due to the bug I found.
> > > > > > >=20
> > > > > > > Where can I read about this errata ?
> > > > > >=20
> > > > > > I have look high and low an cannot find an errata which maps to=
 this fixup.
> > > > > > The closest I get is A-005125 which seems to have another
> > > > > > workaround, I cannot find any evidence that this workaround has=
 been
> > >=20
> > > applied in Linux, can you?
> > > > >=20
> > > > > This is not A-005125.  There was an erratum for this issue with o=
lder silicons
> > >=20
> > > (e.g. erratum PCI-ex 3 for MPC8572).
> > > > > " When its link goes down, the PCI Express controller clears all
> > > > > outstanding transactions with an error indicator and sends a link
> > > > > down exception to the interrupt controller if PEX_PME_MES_DISR[LD=
DD]
> > > > > =3D 0. If, however, any transactions are sent to the controller a=
fter
> > > > > the link down event, they are accepted by the controller and wait
> > > > > for the link to come back up before starting any timeout counters=
 (for
> > >=20
> > > example, completion timeout). There is no mechanism to cancel the new
> > > transactions short of a device HRESET. "
> > > > >=20
> > > > > But it was removed in newer silicon like P2020/P2010 probably bec=
ause a
> > >=20
> > > Machine Check will be triggered in this situation to deal with the st=
alled
> > > instruction and no longer considered it as a hardware issue.
> > > > >=20
> > > >=20
> > > > Maybe this fixup should be configurable then?
> >=20
> > No.  My point is that the problem was no longer considered a hardware i=
ssue because of the machine check mechanism is in place to handle it.  If t=
here is no handling of this special case, we would still experience a syste=
m hang if this situation really occurs.
> >=20
> > > >=20
> > > > > The A-005125 is dealt with in u-boot.
> > >=20
> > > https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
lists.de
> > > nx.de%2Fpipermail%2Fu-boot%2F2013-
> > > August%2F161185.html&data=3D01%7C01%7Cleoyang.li%40nxp.com%7Ccb8a93e
> > > 0090e48eb53a008d4f6b84235%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&
> > > sdata=3D8sR4yoXA4adqMHz6TY%2BvmYpfCBTcYEZHjPuANjz%2F1EQ%3D&reserve
> > > d=3D0
> > > >=20
> > > > Yes, I found it eventually :)
> > > >=20
> > > > However, I cannot return to normal execution. I can follow the code=
 to
> > > > returning from
> > > > machine_check_exception() and moving into ASM handler for returning
> > > > from a ME but then I am a bit lost. It does not seem to be any prob=
lem
> > > > executing, it feels more like a SW bug dealing with machine checks.=
 Don't
> > >=20
> > > known how to diagnose this further and could use some pointers.
> >=20
> > Is the execution returned to the user application?  I doubt the system =
hang is caused by the machine check handling.
> > You can try to comment out the machine check handling code and check if=
 there is any improvement and see if
> > this is related to the machine check handling.
>=20
> It tries to return to user app but I cannot see what happens as the syste=
m lock up when the
> MC returns.
> How do you mean comment out MC handling? The simplest path is the PCI fix=
up which will
> just do regs->nip +=3D 4; and then return to user space. That still does =
not work as
> as soon MC handling returns, the system is locked up.
>=20
> >=20
> > Machine check is a serious situation and not always possible to be reco=
vered from.=20
>=20
> This one should at least not kill the whole system. It is a simple bus er=
ror in user space and
> the app should get SIGBUS and the the system should carry on.=20
>=20
> > I would focus more on debugging why the machine check is triggered by t=
he user space application.
> > Can you locate what code is causing this machine check from user space?=
 =20
> > Is it accessing some hardware related space which is not ready?=20
> > Or is it accessing address that it shouldn't have accessed?
>=20
> of course, this is ongoing and getting closer a solution. The MC looking =
the machine completely
> does not make this any easier though.
> These are 2 separate things, fixing the cause and not having a simple bus=
 error lock up the machine.
> I am focusing on fixing the lockup.
>=20
> I have been following the execution in the kernel and I always end up in =
the ASM returning
> from the MC.
> The other day we got a similar PCI MC(bus error) on T1042 CPU(e5500/e500m=
c) and there
> the system survived. The one thing I see different there is that MSR RI i=
s set
> when entering MC, why is that?
>=20
>  Jocke

Got some more info now, this is a new errata I think, adding EDAC to the mi=
x yields:
[   28.372574] LTSSM:16
[   28.377197] Machine check in kernel mode.
[   28.381201] Caused by (from MCSR=3D10008, MCAR:0x8003e000): Bus - Read D=
ata Bus Error
[   28.388861] Oops: Machine check, sig: 7 [#1]
[   28.393125] P2010 E500v2
[   28.395651] Modules linked in: linux_bcm_knet(PO) linux_user_bde(PO) lin=
ux_kernel_bde(PO)
[   28.403842] CPU: 0 PID: 485 Comm: emxp2_hw_bl Tainted: P           O    =
4.1.43+ #19
[   28.411499] task: db13a0f0 ti: df17c000 task.ti: df17c000
[   28.416894] NIP: 10a66954 LR: 10a66a88 CTR: 0f9e7f44
[   28.421855] REGS: df17df10 TRAP: 0204   Tainted: P           O     (4.1.=
43+)
[   28.428901] MSR: 0002d000 <CE,EE,PR,ME>  CR: 44002428  XER: 20000000
[   28.435267] DEAR: b73cc000 ESR: 00000000=20
GPR00: 10a66a88 bfc21bc0 b7eee4a0 136eb4a0 00000000 00000000 00000000 00000=
000=20
GPR08: 0002d000 0003e000 b738e000 00000000 24002422 11db7334 00000000 00000=
000=20
GPR16: 10f8b054 10f895e5 10f8a8bf 0000b541 0000b541 11ddd380 00000011 00000=
001=20
GPR24: 01a9985e 136f1010 07000000 136eb4a0 00006000 07006000 00000000 00000=
000=20
[   28.467506] NIP [10a66954] 0x10a66954
[   28.471162] LR [10a66a88] 0x10a66a88
[   28.474730] Call Trace:
[   28.477170] ---[ end trace b25436dea505b49d ]---
[   28.481781]=20
[   28.483267] PCIe error(s) detected
[   28.486662] PCIe ERR_DR register: 0x00800000
[   28.490927] PCIe ERR_CAP_STAT register: 0x00000023
[   28.495713] PCIe ERR_CAP_R0 register: 0x00000000
[   28.500324] PCIe ERR_CAP_R1 register: 0x00000000
[   28.504936] PCIe ERR_CAP_R2 register: 0x00000000
[   28.509548] PCIe ERR_CAP_R3 register: 0x00000000

I logged LTSSM and it is 16(link up) and Ref. manual says this about ERR_DR=
 =3D 0x00800000:

PCIe ERR_DR: PCT bit
PCI Express completion time-out. A completion time-out condition was detect=
ed for a non-posted,
outbound PCI Express transaction. An error response is sent back to the req=
uestor. Note that a
completion timeout counter only starts when the non-posted request was able=
 to send to the link partner.
-
A completion time-out on the PCI Express link was detected. Note that a com=
pletion timeout error is a
fatal error. If a completion timeout error is detected, the system has beco=
me unstable. Hot reset is
recommended to restore stability of the system.

This error is not described in any errata I can find, how to workaround thi=
s?

   Jocke
