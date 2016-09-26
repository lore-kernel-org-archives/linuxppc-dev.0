Return-Path: <kda@linux-powerpc.org>
Received: from mail-yb0-x234.google.com (mail-yb0-x234.google.com
 [IPv6:2607:f8b0:4002:c09::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjLZ966QQzDrPs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 20:59:13 +1000 (AEST)
Received: by mail-yb0-x234.google.com with SMTP id t5so10304612yba.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 03:59:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+7wUsz4a0xsFRRRmvYnPUHLCb81m8bd2DL1+LHB65zrpx=ysA@mail.gmail.com>
References: <CAOJe8K0p60fmubbhSHCm0096CTjYjnnfoo_JLuwDcg6fo-=pBg@mail.gmail.com>
 <CA+7wUsz4a0xsFRRRmvYnPUHLCb81m8bd2DL1+LHB65zrpx=ysA@mail.gmail.com>
From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Mon, 26 Sep 2016 13:59:11 +0300
Message-ID: <CAOJe8K3NjfoV52ZJrE6spc6kpOTrZUd4ShLiN4M-Ai1Gd5yx-w@mail.gmail.com>
Subject: Re: ehea crash on boot
To: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=001a1142f2d098d820053d670422
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a1142f2d098d820053d670422
Content-Type: text/plain; charset=UTF-8

On Monday, September 26, 2016, Mathieu Malaterre <
mathieu.malaterre@gmail.com> wrote:

> On Fri, Sep 23, 2016 at 2:50 PM, Denis Kirjanov <kda@linux-powerpc.org
> <javascript:;>> wrote:
> > Heh, another thing to debug :)
> >
> > mm: Hashing failure ! EA=0xd000080080124040 access=0x800000000000000e
> > current=NetworkManager
> > trap=0x300 vsid=0x13d349c ssize=1 base psize=2 psize 2
> pte=0xc0003bc0300301ae
> > mm: Hashing failure ! EA=0xd000080080124040 access=0x800000000000000e
> > current=NetworkManager
> > trap=0x300 vsid=0x13d349c ssize=1 base psize=2 psize 2
> pte=0xc0003bc0300301ae
> > Unable to handle kernel paging request for data at address
> 0xd000080080124040
> > Faulting instruction address: 0xc0000000006f21a0
> > cpu 0x8: Vector: 300 (Data Access) at [c0000005a8b92b50]
> > pc: c0000000006f21a0: .ehea_create_cq+0x160/0x230
> > lr: c0000000006f2164: .ehea_create_cq+0x124/0x230
> > sp: c0000005a8b92dd0
> > msr: 8000000000009032
> > dar: d000080080124040
> > dsisr: 42000000
> > current = 0xc0000005a8b68200
> > paca = 0xc00000000ea94000 softe: 0 irq_happened: 0x01
> > pid = 6787, comm = NetworkManager
> > Linux version 4.8.0-rc6-00214-g4cea877 (kda@ps700) (gcc version 4.8.5
> > 20150623 (Red Hat 4.8.5-4) (GCC) ) #1 SMP Fri Sep 23 15:01:08 MSK 2016
> > enter ? for help
> > [c0000005a8b92dd0] c0000000006f2140 .ehea_create_cq+0x100/0x230
> (unreliable)
> > [c0000005a8b92e70] c0000000006ed448 .ehea_up+0x288/0xed0
> > [c0000005a8b92fe0] c0000000006ee314 .ehea_open+0x44/0x130
> > [c0000005a8b93070] c000000000812324 .__dev_open+0x154/0x220
> > [c0000005a8b93110] c000000000812734 .__dev_change_flags+0xd4/0x1e0
> > [c0000005a8b931b0] c00000000081286c .dev_change_flags+0x2c/0x80
> > [c0000005a8b93240] c000000000829f0c .do_setlink+0x37c/0xe50
> > [c0000005a8b933c0] c00000000082c884 .rtnl_newlink+0x5e4/0x9b0
> > [c0000005a8b936d0] c00000000082cd08 .rtnetlink_rcv_msg+0xb8/0x2f0
> > [c0000005a8b937a0] c00000000084e25c .netlink_rcv_skb+0x12c/0x150
> > [c0000005a8b93830] c000000000829458 .rtnetlink_rcv+0x38/0x60
> > [c0000005a8b938b0] c00000000084d814 .netlink_unicast+0x1e4/0x350
> > [c0000005a8b93960] c00000000084def8 .netlink_sendmsg+0x418/0x480
> > [c0000005a8b93a40] c0000000007defac .sock_sendmsg+0x2c/0x60
> > [c0000005a8b93ab0] c0000000007e0cbc .___sys_sendmsg+0x30c/0x320
> > [c0000005a8b93c90] c0000000007e21bc .__sys_sendmsg+0x4c/0xb0
> > [c0000005a8b93d80] c0000000007e2dec .SyS_socketcall+0x34c/0x3d0
> > [c0000005a8b93e30] c00000000000946c system_call+0x38/0x108
>
> Can you turn UBSAN on for this ?


I'll get back to the problem and send a fix when I'll finish my trip


> --
> Mathieu
>

--001a1142f2d098d820053d670422
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, September 26, 2016, Mathieu Malaterre &lt;<a href=3D"mai=
lto:mathieu.malaterre@gmail.com">mathieu.malaterre@gmail.com</a>&gt; wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">On Fri, Sep 23, 2016 at 2:50 PM, Denis K=
irjanov &lt;<a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &=
#39;kda@linux-powerpc.org&#39;)">kda@linux-powerpc.org</a>&gt; wrote:<br>
&gt; Heh, another thing to debug :)<br>
&gt;<br>
&gt; mm: Hashing failure ! EA=3D0xd000080080124040 access=3D0x8000000000000=
00e<br>
&gt; current=3DNetworkManager<br>
&gt; trap=3D0x300 vsid=3D0x13d349c ssize=3D1 base psize=3D2 psize 2 pte=3D0=
xc0003bc0300301ae<br>
&gt; mm: Hashing failure ! EA=3D0xd000080080124040 access=3D0x8000000000000=
00e<br>
&gt; current=3DNetworkManager<br>
&gt; trap=3D0x300 vsid=3D0x13d349c ssize=3D1 base psize=3D2 psize 2 pte=3D0=
xc0003bc0300301ae<br>
&gt; Unable to handle kernel paging request for data at address 0xd00008008=
0124040<br>
&gt; Faulting instruction address: 0xc0000000006f21a0<br>
&gt; cpu 0x8: Vector: 300 (Data Access) at [c0000005a8b92b50]<br>
&gt; pc: c0000000006f21a0: .ehea_create_cq+0x160/0x230<br>
&gt; lr: c0000000006f2164: .ehea_create_cq+0x124/0x230<br>
&gt; sp: c0000005a8b92dd0<br>
&gt; msr: 8000000000009032<br>
&gt; dar: d000080080124040<br>
&gt; dsisr: 42000000<br>
&gt; current =3D 0xc0000005a8b68200<br>
&gt; paca =3D 0xc00000000ea94000 softe: 0 irq_happened: 0x01<br>
&gt; pid =3D 6787, comm =3D NetworkManager<br>
&gt; Linux version 4.8.0-rc6-00214-g4cea877 (kda@ps700) (gcc version 4.8.5<=
br>
&gt; 20150623 (Red Hat 4.8.5-4) (GCC) ) #1 SMP Fri Sep 23 15:01:08 MSK 2016=
<br>
&gt; enter ? for help<br>
&gt; [c0000005a8b92dd0] c0000000006f2140 .ehea_create_cq+0x100/0x230 (unrel=
iable)<br>
&gt; [c0000005a8b92e70] c0000000006ed448 .ehea_up+0x288/0xed0<br>
&gt; [c0000005a8b92fe0] c0000000006ee314 .ehea_open+0x44/0x130<br>
&gt; [c0000005a8b93070] c000000000812324 .__dev_open+0x154/0x220<br>
&gt; [c0000005a8b93110] c000000000812734 .__dev_change_flags+0xd4/0x1e0<br>
&gt; [c0000005a8b931b0] c00000000081286c .dev_change_flags+0x2c/0x80<br>
&gt; [c0000005a8b93240] c000000000829f0c .do_setlink+0x37c/0xe50<br>
&gt; [c0000005a8b933c0] c00000000082c884 .rtnl_newlink+0x5e4/0x9b0<br>
&gt; [c0000005a8b936d0] c00000000082cd08 .rtnetlink_rcv_msg+0xb8/0x2f0<br>
&gt; [c0000005a8b937a0] c00000000084e25c .netlink_rcv_skb+0x12c/0x150<br>
&gt; [c0000005a8b93830] c000000000829458 .rtnetlink_rcv+0x38/0x60<br>
&gt; [c0000005a8b938b0] c00000000084d814 .netlink_unicast+0x1e4/0x350<br>
&gt; [c0000005a8b93960] c00000000084def8 .netlink_sendmsg+0x418/0x480<br>
&gt; [c0000005a8b93a40] c0000000007defac .sock_sendmsg+0x2c/0x60<br>
&gt; [c0000005a8b93ab0] c0000000007e0cbc .___sys_sendmsg+0x30c/0x320<br>
&gt; [c0000005a8b93c90] c0000000007e21bc .__sys_sendmsg+0x4c/0xb0<br>
&gt; [c0000005a8b93d80] c0000000007e2dec .SyS_socketcall+0x34c/0x3d0<br>
&gt; [c0000005a8b93e30] c00000000000946c system_call+0x38/0x108<br>
<br>
Can you turn UBSAN on for this ?</blockquote><div>=C2=A0</div><div>I&#39;ll=
 get back to the problem and send a fix=C2=A0when I&#39;ll finish=C2=A0my t=
rip<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
--<br>
Mathieu<br>
</blockquote>

--001a1142f2d098d820053d670422--
