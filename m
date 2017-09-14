Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0064.outbound.protection.outlook.com [104.47.36.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtPml5nlRzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 02:55:49 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "leoyang.li@nxp.com" <leoyang.li@nxp.com>, "york.sun@nxp.com"
 <york.sun@nxp.com>
Subject: Re: Machine Check in P2010(e500v2)
Date: Thu, 14 Sep 2017 16:55:40 +0000
Message-ID: <1505408136.5203.83.camel@infinera.com>
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
 <1504961965.31322.72.camel@infinera.com>
In-Reply-To: <1504961965.31322.72.camel@infinera.com>
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

On Sat, 2017-09-09 at 14:59 +0200, Joakim Tjernlund wrote:
> On Sat, 2017-09-09 at 14:45 +0200, Joakim Tjernlund wrote:
> > On Fri, 2017-09-08 at 22:27 +0000, Leo Li wrote:
> > > > -----Original Message-----
> > > > From: Joakim Tjernlund [mailto:Joakim.Tjernlund@infinera.com]
> > > > Sent: Friday, September 08, 2017 7:51 AM
> > > > To: linuxppc-dev@lists.ozlabs.org; Leo Li <leoyang.li@nxp.com>; Yor=
k Sun
> > > > <york.sun@nxp.com>
> > > > Subject: Re: Machine Check in P2010(e500v2)
> > > >=20
> > > > On Fri, 2017-09-08 at 11:54 +0200, Joakim Tjernlund wrote:
> > > > > On Thu, 2017-09-07 at 18:54 +0000, Leo Li wrote:
> > > > > > > -----Original Message-----
> > > > > > > From: Joakim Tjernlund [mailto:Joakim.Tjernlund@infinera.com]
> > > > > > > Sent: Thursday, September 07, 2017 3:41 AM
> > > > > > > To: linuxppc-dev@lists.ozlabs.org; Leo Li <leoyang.li@nxp.com=
>;
> > > > > > > York Sun <york.sun@nxp.com>
> > > > > > > Subject: Re: Machine Check in P2010(e500v2)
> > > > > > >=20
> > > > > > > On Thu, 2017-09-07 at 00:50 +0200, Joakim Tjernlund wrote:
> > > > > > > > On Wed, 2017-09-06 at 21:13 +0000, Leo Li wrote:
> > > > > > > > > > -----Original Message-----
> > > > > > > > > > From: Joakim Tjernlund
> > > > > > > > > > [mailto:Joakim.Tjernlund@infinera.com]
> > > > > > > > > > Sent: Wednesday, September 06, 2017 3:54 PM
> > > > > > > > > > To: linuxppc-dev@lists.ozlabs.org; Leo Li
> > > > > > > > > > <leoyang.li@nxp.com>; York Sun <york.sun@nxp.com>
> > > > > > > > > > Subject: Re: Machine Check in P2010(e500v2)
> > > > > > > > > >=20
> > > > > > > > > > On Wed, 2017-09-06 at 20:28 +0000, Leo Li wrote:
> > > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > > From: Joakim Tjernlund
> > > > > > > > > > > > [mailto:Joakim.Tjernlund@infinera.com]
> > > > > > > > > > > > Sent: Wednesday, September 06, 2017 3:17 PM
> > > > > > > > > > > > To: linuxppc-dev@lists.ozlabs.org; Leo Li
> > > > > > > > > > > > <leoyang.li@nxp.com>; York Sun <york.sun@nxp.com>
> > > > > > > > > > > > Subject: Re: Machine Check in P2010(e500v2)
> > > > > > > > > > > >=20
> > > > > > > > > > > > On Wed, 2017-09-06 at 19:31 +0000, Leo Li wrote:
> > > > > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > > > > From: York Sun
> > > > > > > > > > > > > > Sent: Wednesday, September 06, 2017 10:38 AM
> > > > > > > > > > > > > > To: Joakim Tjernlund
> > > > > > > > > > > > > > <Joakim.Tjernlund@infinera.com>;
> > > > > > > > > > > > > > linuxppc- dev@lists.ozlabs.org; Leo Li
> > > > > > > > > > > > > > <leoyang.li@nxp.com>
> > > > > > > > > > > > > > Subject: Re: Machine Check in P2010(e500v2)
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Scott is no longer with Freescale/NXP. Adding L=
eo.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > On 09/05/2017 01:40 AM, Joakim Tjernlund wrote:
> > > > > > > > > > > > > > > So after some debugging I found this bug:
> > > > > > > > > > > > > > > @@ -996,7 +998,7 @@ int
> > > > > > > > > > > > > > > fsl_pci_mcheck_exception(struct pt_regs
> > > > > > > > > >=20
> > > > > > > > > > *regs)
> > > > > > > > > > > > > > >          if (is_in_pci_mem_space(addr)) {
> > > > > > > > > > > > > > >                  if (user_mode(regs)) {
> > > > > > > > > > > > > > >                          pagefault_disable();
> > > > > > > > > > > > > > > -                       ret =3D get_user(regs=
->nip, &inst);
> > > > > > > > > > > > > > > +                       ret =3D get_user(inst=
,
> > > > > > > > > > > > > > > + (__u32 __user *)regs->nip);
> > > > > > > > > > > > > > >                          pagefault_enable();
> > > > > > > > > > > > > > >                  } else {
> > > > > > > > > > > > > > >                          ret =3D
> > > > > > > > > > > > > > > probe_kernel_address(regs->nip, inst);
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > However, the kernel still locked up after fix=
ing that.
> > > > > > > > > > > > > > > Now I wonder why this fixup is there in the f=
irst place?
> > > > > > > > > > > > > > > The routine will not really fixup the insn, j=
ust
> > > > > > > > > > > > > > > return 0xffffffff for the failing read and th=
en advance the
> > > >=20
> > > > process NIP.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > You are right.  The code here only gives 0xffffff=
ff to
> > > > > > > > > > > > > the load instructions and
> > > > > > > > > > > >=20
> > > > > > > > > > > > continue with the next instruction when the load
> > > > > > > > > > > > instruction is causing the machine check.  This wil=
l
> > > > > > > > > > > > prevent a system lockup when reading from PCI/Rapid=
IO device
> > > >=20
> > > > which is link down.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > I don't know what is actual problem in your case.
> > > > > > > > > > > > > Maybe it is a write
> > > > > > > > > > > >=20
> > > > > > > > > > > > instruction instead of read?   Or the code is in a =
infinite loop
> > > >=20
> > > > waiting for
> > > > > > >=20
> > > > > > > a
> > > > > > > > > >=20
> > > > > > > > > > valid
> > > > > > > > > > > > read result?  Are you able to do some further debug=
ging
> > > > > > > > > > > > with the NIP correctly printed?
> > > > > > > > > > > > >=20
> > > > > > > > > > > >=20
> > > > > > > > > > > > According to the MC it is a Read and the NIP also l=
eads
> > > > > > > > > > > > to a read in the
> > > > > > > > > >=20
> > > > > > > > > > program.
> > > > > > > > > > > > ATM, I have disabled the fixup but I will enable th=
at again.
> > > > > > > > > > > > Question, is it safe add a small printk when this M=
C
> > > > > > > > > > > > happens(after fixing up)? I need to see that it has
> > > > > > > > > > > > happened as the error is somewhat
> > > > > > > > > >=20
> > > > > > > > > > random.
> > > > > > > > > > >=20
> > > > > > > > > > > I think it is safe to add printk as the current machi=
ne
> > > > > > > > > > > check handlers are also
> > > > > > > > > >=20
> > > > > > > > > > using printk.
> > > > > > > > > >=20
> > > > > > > > > > I hope so, but if the fixup fires there is no printk at=
 all so I was a bit
> > > >=20
> > > > unsure.
> > > > > > > > > > Don't like this fixup though, is there not a better way=
 than
> > > > > > > > > > faking a read to user space(or kernel for that matter) =
?
> > > > > > > > >=20
> > > > > > > > > I don't have a better idea.  Without the fixup, the offen=
ding
> > > > > > > > > load instruction
> > > > > > >=20
> > > > > > > will never finish if there is anything wrong with the backing
> > > > > > > device and freeze the whole system.  Do you have any suggesti=
on in mind?
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > But it never finishes the load, it just fakes a load of
> > > > > > > > 0xfffffffff, for user space I rather have it signal a SIGBU=
S but
> > > > > > > > that does not seem to work either, at least not for us but =
that
> > > > > > > > could be a bug in general MC code
> > > > > > >=20
> > > > > > > maybe.
> > > > > > > > This fixup might be valid for kernel only as it has never w=
orked
> > > > > > > > for user space
> > > > > > >=20
> > > > > > > due to the bug I found.
> > > > > > > >=20
> > > > > > > > Where can I read about this errata ?
> > > > > > >=20
> > > > > > > I have look high and low an cannot find an errata which maps =
to this fixup.
> > > > > > > The closest I get is A-005125 which seems to have another
> > > > > > > workaround, I cannot find any evidence that this workaround h=
as been
> > > >=20
> > > > applied in Linux, can you?
> > > > > >=20
> > > > > > This is not A-005125.  There was an erratum for this issue with=
 older silicons
> > > >=20
> > > > (e.g. erratum PCI-ex 3 for MPC8572).
> > > > > > " When its link goes down, the PCI Express controller clears al=
l
> > > > > > outstanding transactions with an error indicator and sends a li=
nk
> > > > > > down exception to the interrupt controller if PEX_PME_MES_DISR[=
LDDD]
> > > > > > =3D 0. If, however, any transactions are sent to the controller=
 after
> > > > > > the link down event, they are accepted by the controller and wa=
it
> > > > > > for the link to come back up before starting any timeout counte=
rs (for
> > > >=20
> > > > example, completion timeout). There is no mechanism to cancel the n=
ew
> > > > transactions short of a device HRESET. "
> > > > > >=20
> > > > > > But it was removed in newer silicon like P2020/P2010 probably b=
ecause a
> > > >=20
> > > > Machine Check will be triggered in this situation to deal with the =
stalled
> > > > instruction and no longer considered it as a hardware issue.
> > > > > >=20
> > > > >=20
> > > > > Maybe this fixup should be configurable then?
> > >=20
> > > No.  My point is that the problem was no longer considered a hardware=
 issue because of the machine check mechanism is in place to handle it.  If=
 there is no handling of this special case, we would still experience a sys=
tem hang if this situation really occurs.
> > >=20
> > > > >=20
> > > > > > The A-005125 is dealt with in u-boot.
> > > >=20
> > > > https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Flists.de
> > > > nx.de%2Fpipermail%2Fu-boot%2F2013-
> > > > August%2F161185.html&data=3D01%7C01%7Cleoyang.li%40nxp.com%7Ccb8a93=
e
> > > > 0090e48eb53a008d4f6b84235%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&
> > > > sdata=3D8sR4yoXA4adqMHz6TY%2BvmYpfCBTcYEZHjPuANjz%2F1EQ%3D&reserve
> > > > d=3D0
> > > > >=20
> > > > > Yes, I found it eventually :)
> > > > >=20
> > > > > However, I cannot return to normal execution. I can follow the co=
de to
> > > > > returning from
> > > > > machine_check_exception() and moving into ASM handler for returni=
ng
> > > > > from a ME but then I am a bit lost. It does not seem to be any pr=
oblem
> > > > > executing, it feels more like a SW bug dealing with machine check=
s. Don't
> > > >=20
> > > > known how to diagnose this further and could use some pointers.
> > >=20
> > > Is the execution returned to the user application?  I doubt the syste=
m hang is caused by the machine check handling.
> > > You can try to comment out the machine check handling code and check =
if there is any improvement and see if
> > > this is related to the machine check handling.
> >=20
> > It tries to return to user app but I cannot see what happens as the sys=
tem lock up when the
> > MC returns.
> > How do you mean comment out MC handling? The simplest path is the PCI f=
ixup which will
> > just do regs->nip +=3D 4; and then return to user space. That still doe=
s not work as
> > as soon MC handling returns, the system is locked up.
> >=20
> > >=20
> > > Machine check is a serious situation and not always possible to be re=
covered from.=20
> >=20
> > This one should at least not kill the whole system. It is a simple bus =
error in user space and
> > the app should get SIGBUS and the the system should carry on.=20
> >=20
> > > I would focus more on debugging why the machine check is triggered by=
 the user space application.
> > > Can you locate what code is causing this machine check from user spac=
e? =20
> > > Is it accessing some hardware related space which is not ready?=20
> > > Or is it accessing address that it shouldn't have accessed?
> >=20
> > of course, this is ongoing and getting closer a solution. The MC lookin=
g the machine completely
> > does not make this any easier though.
> > These are 2 separate things, fixing the cause and not having a simple b=
us error lock up the machine.
> > I am focusing on fixing the lockup.
> >=20
> > I have been following the execution in the kernel and I always end up i=
n the ASM returning
> > from the MC.
> > The other day we got a similar PCI MC(bus error) on T1042 CPU(e5500/e50=
0mc) and there
> > the system survived. The one thing I see different there is that MSR RI=
 is set
> > when entering MC, why is that?
>=20
> Before you ask, I have tried to add MSR_RI to both msr and mcsrr1. Didn't=
 help.

I managed to provoke another Machine Check, much earlier this time:
[   15.047108] Machine check in kernel mode.
[   15.051120] Caused by (from MCSR=3D10008): Bus - Read Data Bus Error
[   15.057302] Oops: Machine check, sig: 7 [#1]
[   15.061567] P1010 RDB
[   15.063832] Modules linked in: linux_bcm_knet(PO) linux_user_bde(PO) lin=
ux_kernel_bde(PO)
[   15.072022] CPU: 0 PID: 472 Comm: emxp2_hw_bl Tainted: P           O    =
4.1.43+ #52
[   15.079680] task: db1a7990 ti: df18c000 task.ti: df18c000
[   15.085075] NIP: 00000000 LR: 109e7648 CTR: 00000000
[   15.090036] REGS: df18df10 TRAP: 0204   Tainted: P           O     (4.1.=
43+)
[   15.097082] MSR: 0002d000 <CE,EE,PR,ME>  CR: 280004e8  XER: 20000000
[   15.103448] DEAR: b6e44140 ESR: 00000000=20
GPR00: 10ac1160 bfa44010 b79734a0 136eb4a0 bfa44030 01010101 bfa44038 00000=
020=20
GPR08: 00000000 b6e13000 063e521e 0f9ed9c4 22000422 11db7334 00000000 00000=
000=20
GPR16: 10f8b054 10f895e5 10f8a8bf 00031150 136eb4d0 00030000 00031140 00031=
140=20
GPR24: 00000000 00000000 136f10a0 00000000 00000000 00000000 00031140 136eb=
4a0=20
[   15.135690] NIP [00000000]   (null)
[   15.139174] LR [109e7648] 0x109e7648
[   15.142743] Call Trace:
[   15.145184] ---[ end trace c00af6117685cb6e ]---

The fun part is that now the OS did NOT lock up!

Looking that the faulting process, emxp2_hw_bl, I see it is in Zombie state=
(cd /proc/472):
cat status=20
Name:	emxp2_hw_bl
State:	Z (zombie)
Tgid:	472
Ngid:	0
Pid:	472
PPid:	468
TracerPid:	0
Uid:	0	0	0	0
Gid:	0	0	0	0
FDSize:	0
Groups:=09
Threads:	8
SigQ:	0/3462
SigPnd:	0000000000000000
ShdPnd:	0000000000000000
SigBlk:	0000000000000000
SigIgn:	0000000000001000
SigCgt:	00000001c0000628
CapInh:	0000000000000000
CapPrm:	0000003fffffffff
CapEff:	0000003fffffffff
CapBnd:	0000003fffffffff
Cpus_allowed:	1
Cpus_allowed_list:	0
voluntary_ctxt_switches:	1126
nonvoluntary_ctxt_switches:	376

This even after parent process has called waitid(2) for emxp2_hw_bl
If I now do a kill -s SIGBUS/TERM <pid of emxp2_hw_bl> this
signal is propagated to the parent and emxp2_hw_bl goes away.

Stack:
cat stack=20
[<c0071c04>] do_futex+0x150/0x874
[<c0027670>] do_exit+0x4e8/0x7d0
[<c000a164>] die+0x178/0x1d8
[<c000a7c8>] machine_check_exception+0xcc/0x17c
[<c000dd94>] ret_from_mcheck_exc+0x0/0x144

So emxp2_hw_bl is stuck somewhere in down in machine_check_exception().
This all looks like Linux bugs when asked to kill a user process
from Machine Check.

I don't think I will get any further without some pointers now.

 Jocke
