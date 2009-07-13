Return-Path: <skrishnakar@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AAC1DB708F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 02:07:13 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40907130901r181fea87k3f8da151a50edb75@mail.gmail.com>
References: <6213bc560907130016n2f2d5066t3dc88032200da8ef@mail.gmail.com>
	<fa686aa40907130802h3a6875f7gf21d41974974a7e4@mail.gmail.com>
	<6213bc560907130839t36e28d5fr34191ccb290c9cf8@mail.gmail.com>
	<fa686aa40907130901r181fea87k3f8da151a50edb75@mail.gmail.com>
Date: Mon, 13 Jul 2009 21:37:11 +0530
Message-ID: <6213bc560907130907s72a5396cqa843e53ed21d19cf@mail.gmail.com>
Subject: Re: Soft Reset for PPC44x Virtex 5 hangs saying Restarting System
From: srikanth krishnakar <skrishnakar@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: multipart/alternative; boundary=000e0cd20ddcc34198046e9883c6
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd20ddcc34198046e9883c6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Mon, Jul 13, 2009 at 9:31 PM, Grant Likely <grant.likely@secretlab.ca>wrote:

> On Mon, Jul 13, 2009 at 9:39 AM, srikanth
> krishnakar<skrishnakar@gmail.com> wrote:
> >
> >
> > On Mon, Jul 13, 2009 at 8:32 PM, Grant Likely <grant.likely@secretlab.ca
> >
> > wrote:
> >>
> >> On Mon, Jul 13, 2009 at 1:16 AM, srikanth
> >> krishnakar<skrishnakar@gmail.com> wrote:
> >> > Hi all,
> >> >
> >> > Kernel : Linux-2.6.29
> >> > Arch: Powerpc (ppc44x)
> >> > Target: Xilinx ML507 Virtex5
> >> >
> >> > I have an issue in "Reset System" of Xilinx ML507 target board. I am
> >> > using
> >> > Compact Flash to boot the target ( using system ACE file to boot the
> >> > target), during the process reset or reboot command on the target, I
> am
> >> > not
> >> > able to reboot the target completely, here is the snapshot:
> >>
> >> Where is your boot code located?  In BRAM?  or SDRAM?
> >
> > It is located in BRAM.
> >
>
> Then most likely the process of booting modifies the initial data in
> BRAM such that it will not be able to reboot the system.
>
> > How can I reboot the system, while resetting the FPGA core completely ?
>
> To reset and reconfigure the FPGA, you need to modify the systemace
> driver to provide a system reset routine.  See the systemace user
> manual for details on how to do this.
>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>

Thank You very much.

Will look into it.

Regards
Srikanth Krishnakar
**********************

--000e0cd20ddcc34198046e9883c6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Jul 13, 2009 at 9:31 PM, Grant L=
ikely <span dir=3D"ltr">&lt;<a href=3D"mailto:grant.likely@secretlab.ca">gr=
ant.likely@secretlab.ca</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt=
 0pt 0.8ex; padding-left: 1ex;">
On Mon, Jul 13, 2009 at 9:39 AM, srikanth<br>
<div class=3D"im">krishnakar&lt;<a href=3D"mailto:skrishnakar@gmail.com">sk=
rishnakar@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Jul 13, 2009 at 8:32 PM, Grant Likely &lt;<a href=3D"mailto:gr=
ant.likely@secretlab.ca">grant.likely@secretlab.ca</a>&gt;<br>
&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Jul 13, 2009 at 1:16 AM, srikanth<br>
&gt;&gt; krishnakar&lt;<a href=3D"mailto:skrishnakar@gmail.com">skrishnakar=
@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt; Hi all,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Kernel : Linux-2.6.29<br>
&gt;&gt; &gt; Arch: Powerpc (ppc44x)<br>
&gt;&gt; &gt; Target: Xilinx ML507 Virtex5<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I have an issue in &quot;Reset System&quot; of Xilinx ML507 t=
arget board. I am<br>
&gt;&gt; &gt; using<br>
&gt;&gt; &gt; Compact Flash to boot the target ( using system ACE file to b=
oot the<br>
&gt;&gt; &gt; target), during the process reset or reboot command on the ta=
rget, I am<br>
&gt;&gt; &gt; not<br>
&gt;&gt; &gt; able to reboot the target completely, here is the snapshot:<b=
r>
&gt;&gt;<br>
&gt;&gt; Where is your boot code located? =A0In BRAM? =A0or SDRAM?<br>
&gt;<br>
&gt; It is located in BRAM.<br>
&gt;<br>
<br>
</div>Then most likely the process of booting modifies the initial data in<=
br>
BRAM such that it will not be able to reboot the system.<br>
<div class=3D"im"><br>
&gt; How can I reboot the system, while resetting the FPGA core completely =
?<br>
<br>
</div>To reset and reconfigure the FPGA, you need to modify the systemace<b=
r>
driver to provide a system reset routine. =A0See the systemace user<br>
manual for details on how to do this.<br>
<div><div></div><div class=3D"h5"><br>
g.<br>
<br>
--<br>
Grant Likely, B.Sc., P.Eng.<br>
Secret Lab Technologies Ltd.<br>
</div></div></blockquote></div><br>Thank You very much.<br><br>Will look in=
to it.<br><br clear=3D"all">Regards<br>Srikanth Krishnakar<br>*************=
*********<br>

--000e0cd20ddcc34198046e9883c6--
