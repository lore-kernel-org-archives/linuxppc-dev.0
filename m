Return-Path: <Paul.McKenney@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wz3vs1TbrzDr4s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 01:47:53 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TFliu6116431
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 11:47:50 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bd1nq1jvb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 11:47:50 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <Paul.McKenney@us.ibm.com>;
 Thu, 29 Jun 2017 09:47:48 -0600
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5TFlksJ9503210
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 08:47:46 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD7B1BE042
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 09:47:46 -0600 (MDT)
Received: from d50lp33.co.us.ibm.com (unknown [9.17.249.38])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS id A8721BE03E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 09:47:46 -0600 (MDT)
Received: from localhost
 by d50lp33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <Paul.McKenney@us.ibm.com>;
 Thu, 29 Jun 2017 09:47:46 -0600
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <linuxppc-dev@lists.ozlabs.org> from <Paul.McKenney@us.ibm.com>;
 Thu, 29 Jun 2017 15:47:41 -0000
MIME-Version: 1.0
In-Reply-To: <20170630004534.228f7c08@roar.ozlabs.ibm.com>
Subject: Re: [linux-next] cpus stalls detected few hours after booting next
 kernel
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, mpe
 <mpe@ellerman.id.au>, paulus@samba.org, sachinp
 <sachinp@linux.vnet.ibm.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, paulmck@linux.vnet.ibm.com
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Thu, 29 Jun 2017 08:47:35 -0700
References: <1498728106.19484.21.camel@abdul><20170629193614.376e27e6@roar.ozlabs.ibm.com><20170629202305.6187367f@roar.ozlabs.ibm.com>
 <20170630004534.228f7c08@roar.ozlabs.ibm.com>
Content-type: multipart/alternative;
 Boundary="0__=07BB0BDDDFC223D68f9e8a93df938690918c07BB0BDDDFC223D6"
Message-Id: <OFE464A150.B65002BA-ON8825814E.0051A546-8825814E.0056C106@notes.na.collabserv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--0__=07BB0BDDDFC223D68f9e8a93df938690918c07BB0BDDDFC223D6
Content-Transfer-Encoding: quoted-printable
Content-type: text/plain; charset=US-ASCII

[ Adding my IMAP address on CC to avoid another Lotus Notes reply to LKML.
Man, it has been more than 15 years since the last one!!! ]

Nicholas Piggin <npiggin@gmail.com> wrote on 06/29/2017 07:45:34 AM:
> On Thu, 29 Jun 2017 20:23:05 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>
> > On Thu, 29 Jun 2017 19:36:14 +1000
> > Nicholas Piggin <npiggin@gmail.com> wrote:
>
> > > I don't *think* the replay-wakeup-interrupt patch is directly
> involved, but
> > > it's likely to be one of the idle patches.
>
> Okay this turned out to be misconfigured sleep states I added for the
> simulator, sorry for the false alarm.
>
> > Although you have this in the backtrace. I wonder if that's a stuck
> > lock in rcu=5Fprocess=5Fcallbacks?
>
> So this spinlock becomes top of the list of suspects. Can you try
> enabling lockdep and try to reproduce it?

Hopefully lockdep would give you the answer.

But if that doesn't help, the rcu=5Finvoke=5Fcallback event trace would
identify the function that the stuck callback invoked.

							Thanx, Paul

> > [ 5948.345539] CPU: 63 PID: 7360 Comm: rs:main Q:Reg Not tainted \
> > 4.12.0-rc7-next-20170628 #2 [ 5948.345612] task: c000000f1c14e600
> task.stack: \
> > c000000f1c1e8000 [ 5948.345672] NIP: c0000000009c7a10 LR:
> c0000000009c7a08 CTR: \
> > c00000000015eda0 [ 5948.358553] REGS: c000000f1c1eb150 TRAP: 0501
> Not tainted  \
> > (4.12.0-rc7-next-20170628) [ 5948.358623] MSR: 9000000000009033 \
> > <SF,HV,EE,ME,IR,DR,RI,LE> [ 5948.358626]   CR: 28082884  XER: 20000000
> > [ 5948.358706] CFAR: c0000000009c7a28 SOFTE: 1
> > GPR00: c00000000015f14c c000000f1c1eb3d0 c000000001062b00
0000000000000001
> > GPR04: c000000fff6e6180 0000000000000000 0000000000000001
00000000000000cc
> > GPR08: 0000000000000001 000000008000004a 0000000000000000
0000000000000000
> > GPR12: c00000000015eda0 c00000000fd55a80
> > [ 5948.358986] NIP [c0000000009c7a10] =5Fraw=5Fspin=5Flock=5Firqsave+0x=
90/0x100
> > [ 5948.359043] LR [c0000000009c7a08] =5Fraw=5Fspin=5Flock=5Firqsave+0x8=
8/0x100
> > [ 5948.359099] Call Trace:
> > [ 5948.359123] [c000000f1c1eb3d0] [0000000000000001] 0x1 (unreliable)
> > [ 5948.359182] [c000000f1c1eb410] [c00000000015f14c] \
> d> rcu=5Fprocess=5Fcallbacks+0x3ac/0x620 [ 5948.359252] [c000000f1c1eb4c0=
] \
> > [c0000000000e1e0c] =5F=5Fdo=5Fsoftirq+0x14c/0x3a0 [ 5948.365958]
> [c000000f1c1eb5b0] \
> > [c0000000000e2448] irq=5Fexit+0x108/0x120 [ 5948.366016]
[c000000f1c1eb5d0] \
> > [c0000000000232b4] timer=5Finterrupt+0xa4/0xe0 [ 5948.366075]
> [c000000f1c1eb600] \
> > [c000000000009208] decrementer=5Fcommon+0x158/0x160 [ 5948.366149]
> --- interrupt: 901 \
> > at start=5Fthis=5Fhandle+0xd0/0x4b0  LR =3D jbd2=5F=5Fjournal=5Fstart+0=
x17c/0x2b0
> > [ 5948.366242] [c000000f1c1eb8f0] [c000000f20a5cb00]
> 0xc000000f20a5cb00 (unreliable)
> > [ 5948.366314] [c000000f1c1eba00] [c00000000040717c]
> jbd2=5F=5Fjournal=5Fstart+0x17c/0x2b0
> > [ 5948.366388] [c000000f1c1eba70] [c00000000038edf4] \
> > =5F=5Fext4=5Fjournal=5Fstart=5Fsb+0x84/0x180 [ 5948.366459] [c000000f1c=
1ebad0] \
> > [c0000000003b47dc] ext4=5Fda=5Fwrite=5Fbegin+0x17c/0x520 [ 5948.366532]
> [c000000f1c1ebb90] \
> > [c00000000021f9c8] generic=5Fperform=5Fwrite+0xe8/0x250 [ 5948.366604]
> [c000000f1c1ebc20] \
> > [c000000000220d20] =5F=5Fgeneric=5Ffile=5Fwrite=5Fiter+0x200/0x240 [ 59=
48.366677]
\
> > [c000000f1c1ebc80] [c00000000039d614] ext4=5Ffile=5Fwrite=5Fiter+0x2e4/
> 0x4d0 [ 5948.373255] \
> > [c000000f1c1ebd00] [c0000000002e13c0] =5F=5Fvfs=5Fwrite+0x120/0x200 [
> 5948.373313] \
> > [c000000f1c1ebd90] [c0000000002e2c48] vfs=5Fwrite+0xc8/0x240
[ 5948.373371] \
> > [c000000f1c1ebde0] [c0000000002e4940] SyS=5Fwrite+0x60/0x110
[ 5948.373430] \
> > [c000000f1c1ebe30] [c00000000000b8e0] system=5Fcall+0x38/0xdc
[ 5948.373486] \
> > Instruction dump: [ 5948.373521] 7fe3fb78 e8010010 eba1ffe8
> ebc1fff0 ebe1fff8 \
> > 7c0803a6 4e800020 8bad028a  [ 5948.373592] 7fe3fb78 4b64db15
> 60000000 7c210b78 \
> > <e92d0000> 89290009 792affe3 40820048  [ 5948.374515] Sending NMI
> from CPU 74 to CPUs \
> >
>

--0__=07BB0BDDDFC223D68f9e8a93df938690918c07BB0BDDDFC223D6
Content-Transfer-Encoding: quoted-printable
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body><p><tt><font size=3D"2">[ Adding my IMAP address on CC to avoid=
 another Lotus Notes reply to LKML. Man, it has been more than 15 years sin=
ce the last one!!! ]</font></tt><br><br><tt><font size=3D"2">Nicholas Piggi=
n &lt;npiggin@gmail.com&gt; wrote on 06/29/2017 07:45:34 AM:<br>&gt; On Thu=
, 29 Jun 2017 20:23:05 +1000<br>&gt; Nicholas Piggin &lt;npiggin@gmail.com&=
gt; wrote:<br>&gt; <br>&gt; &gt; On Thu, 29 Jun 2017 19:36:14 +1000<br>&gt;=
 &gt; Nicholas Piggin &lt;npiggin@gmail.com&gt; wrote:<br>&gt; <br>&gt; &gt=
; &gt; I don't *think* the replay-wakeup-interrupt patch is directly <br>&g=
t; involved, but<br>&gt; &gt; &gt; it's likely to be one of the idle patche=
s. &nbsp;<br>&gt; <br>&gt; Okay this turned out to be misconfigured sleep s=
tates I added for the<br>&gt; simulator, sorry for the false alarm.<br>&gt;=
 <br>&gt; &gt; Although you have this in the backtrace. I wonder if that's =
a stuck<br>&gt; &gt; lock in rcu=5Fprocess=5Fcallbacks?<br>&gt; <br>&gt; So=
 this spinlock becomes top of the list of suspects. Can you try<br>&gt; ena=
bling lockdep and try to reproduce it?</font></tt><br><br><tt><font size=3D=
"2">Hopefully lockdep would give you the answer.</font></tt><br><br><tt><fo=
nt size=3D"2">But if that doesn't help, the </font></tt><tt><font size=3D"2=
">rcu=5Finvoke=5Fcallback event trace would</font></tt><br><tt><font size=
=3D"2">identify the function that the stuck callback invoked.</font></tt><b=
r><br><tt><font size=3D"2">                                                =
        Thanx, Paul</font></tt><br><br><tt><font size=3D"2">&gt; &gt; [ 594=
8.345539] CPU: 63 PID: 7360 Comm: rs:main Q:Reg Not tainted \<br>&gt; &gt; =
4.12.0-rc7-next-20170628 #2 [ 5948.345612] task: c000000f1c14e600 <br>&gt; =
task.stack: \<br>&gt; &gt; c000000f1c1e8000 [ 5948.345672] NIP: c0000000009=
c7a10 LR: <br>&gt; c0000000009c7a08 CTR: \<br>&gt; &gt; c00000000015eda0 [ =
5948.358553] REGS: c000000f1c1eb150 TRAP: 0501 <br>&gt; Not tainted &nbsp;\=
<br>&gt; &gt; (4.12.0-rc7-next-20170628) [ 5948.358623] MSR: 90000000000090=
33 \<br>&gt; &gt; &lt;SF,HV,EE,ME,IR,DR,RI,LE&gt; [ 5948.358626] &nbsp; CR:=
 28082884 &nbsp;XER: 20000000<br>&gt; &gt; [ 5948.358706] CFAR: c0000000009=
c7a28 SOFTE: 1 <br>&gt; &gt; GPR00: c00000000015f14c c000000f1c1eb3d0 c0000=
00001062b00 0000000000000001 <br>&gt; &gt; GPR04: c000000fff6e6180 00000000=
00000000 0000000000000001 00000000000000cc <br>&gt; &gt; GPR08: 00000000000=
00001 000000008000004a 0000000000000000 0000000000000000 <br>&gt; &gt; GPR1=
2: c00000000015eda0 c00000000fd55a80 <br>&gt; &gt; [ 5948.358986] NIP [c000=
0000009c7a10] =5Fraw=5Fspin=5Flock=5Firqsave+0x90/0x100<br>&gt; &gt; [ 5948=
.359043] LR [c0000000009c7a08] =5Fraw=5Fspin=5Flock=5Firqsave+0x88/0x100<br=
>&gt; &gt; [ 5948.359099] Call Trace:<br>&gt; &gt; [ 5948.359123] [c000000f=
1c1eb3d0] [0000000000000001] 0x1 (unreliable)<br>&gt; &gt; [ 5948.359182] [=
c000000f1c1eb410] [c00000000015f14c] \<br>&gt; d&gt; rcu=5Fprocess=5Fcallba=
cks+0x3ac/0x620 [ 5948.359252] [c000000f1c1eb4c0] \<br>&gt; &gt; [c00000000=
00e1e0c] =5F=5Fdo=5Fsoftirq+0x14c/0x3a0 [ 5948.365958] <br>&gt; [c000000f1c=
1eb5b0] \<br>&gt; &gt; [c0000000000e2448] irq=5Fexit+0x108/0x120 [ 5948.366=
016] [c000000f1c1eb5d0] \<br>&gt; &gt; [c0000000000232b4] timer=5Finterrupt=
+0xa4/0xe0 [ 5948.366075] <br>&gt; [c000000f1c1eb600] \<br>&gt; &gt; [c0000=
00000009208] decrementer=5Fcommon+0x158/0x160 [ 5948.366149] <br>&gt; --- i=
nterrupt: 901 \<br>&gt; &gt; at start=5Fthis=5Fhandle+0xd0/0x4b0 &nbsp;LR =
=3D jbd2=5F=5Fjournal=5Fstart+0x17c/0x2b0</font></tt><br><tt><font size=3D"=
2">&gt; &gt; [ 5948.366242] [c000000f1c1eb8f0] [c000000f20a5cb00] <br>&gt; =
0xc000000f20a5cb00 (unreliable)<br>&gt; &gt; [ 5948.366314] [c000000f1c1eba=
00] [c00000000040717c] <br>&gt; jbd2=5F=5Fjournal=5Fstart+0x17c/0x2b0<br>&g=
t; &gt; [ 5948.366388] [c000000f1c1eba70] [c00000000038edf4] \<br>&gt; &gt;=
 =5F=5Fext4=5Fjournal=5Fstart=5Fsb+0x84/0x180 [ 5948.366459] [c000000f1c1eb=
ad0] \<br>&gt; &gt; [c0000000003b47dc] ext4=5Fda=5Fwrite=5Fbegin+0x17c/0x52=
0 [ 5948.366532] <br>&gt; [c000000f1c1ebb90] \<br>&gt; &gt; [c00000000021f9=
c8] generic=5Fperform=5Fwrite+0xe8/0x250 [ 5948.366604]<br>&gt; [c000000f1c=
1ebc20] \<br>&gt; &gt; [c000000000220d20] =5F=5Fgeneric=5Ffile=5Fwrite=5Fit=
er+0x200/0x240 [ 5948.366677] \<br>&gt; &gt; [c000000f1c1ebc80] [c000000000=
39d614] ext4=5Ffile=5Fwrite=5Fiter+0x2e4/<br>&gt; 0x4d0 [ 5948.373255] \<br=
>&gt; &gt; [c000000f1c1ebd00] [c0000000002e13c0] =5F=5Fvfs=5Fwrite+0x120/0x=
200 [ <br>&gt; 5948.373313] \<br>&gt; &gt; [c000000f1c1ebd90] [c0000000002e=
2c48] vfs=5Fwrite+0xc8/0x240 [ 5948.373371] \<br>&gt; &gt; [c000000f1c1ebde=
0] [c0000000002e4940] SyS=5Fwrite+0x60/0x110 [ 5948.373430] \<br>&gt; &gt; =
[c000000f1c1ebe30] [c00000000000b8e0] system=5Fcall+0x38/0xdc [ 5948.373486=
] \<br>&gt; &gt; Instruction dump: [ 5948.373521] 7fe3fb78 e8010010 eba1ffe=
8 <br>&gt; ebc1fff0 ebe1fff8 \<br>&gt; &gt; 7c0803a6 4e800020 8bad028a &nbs=
p;[ 5948.373592] 7fe3fb78 4b64db15 <br>&gt; 60000000 7c210b78 \<br>&gt; &gt=
; &lt;e92d0000&gt; 89290009 792affe3 40820048 &nbsp;[ 5948.374515] Sending =
NMI <br>&gt; from CPU 74 to CPUs \<br>&gt; &gt; <br>&gt; <br></font></tt><B=
R>
</body></html>

--0__=07BB0BDDDFC223D68f9e8a93df938690918c07BB0BDDDFC223D6--
