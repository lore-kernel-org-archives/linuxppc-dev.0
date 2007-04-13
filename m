Return-Path: <Hiroaki_Fuse@hq.scei.sony.co.jp>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 37030DDF39
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 16:20:15 +1000 (EST)
Received: from mail2.sony.co.jp (localhost [127.0.0.1])
	by mail2.sony.co.jp (R8/Sony) with ESMTP id l3D6KDKY013134
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 15:20:13 +0900 (JST)
Received: from mailgw02.scei.sony.co.jp (mailgw02.scei.sony.co.jp [43.27.73.8])
	by mail2.sony.co.jp (R8/Sony) with SMTP id l3D6KD0O013124
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 15:20:13 +0900 (JST)
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [Cbe-oss-dev] [ANNOUNCE] petitboot v0.0.1
MIME-Version: 1.0
Message-ID: <OFA72EABF2.7008AEF7-ON492572BC.00220AA6-492572BC.00226043@hq.scei.sony.co.jp>
From: Hiroaki Fuse <Hiroaki_Fuse@hq.scei.sony.co.jp>
Date: Fri, 13 Apr 2007 15:20:10 +0900
Content-Type: multipart/alternative;
	boundary="=_alternative 00226017492572BC_="
Cc: linuxppc-dev@ozlabs.org,
	cbe-oss-dev-bounces+hiroaki_fuse=hq.scei.sony.co.jp@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 00226017492572BC_=
Content-Type: text/plain; charset="us-ascii"

Jeremy-san,

I tried to use petitboot v0.0.1 and found a problem.

I use a following kboot.conf.

---
default=linux
timeout=10
root=LABEL=/
linux='/boot/vmlinux-2.6.16 initrd=/boot/initrd.img-2.6.16 '
linux21='/boot/vmlinux-2.6.21 initrd=/boot/initrd.img-2.6.21 '
---

I saw three entries(root, linux and linux21) and I can not boot any 
kernel.

So I changed my kboot.conf as follows.

---
default=linux
timeout=10
linux='/boot/vmlinux-2.6.16 root=LABEL=/ initrd=/boot/initrd.img-2.6.16 '
linux21='/boot/vmlinux-2.6.21 root=LABEL=/ initrd=/boot/initrd.img-2.6.21 
'
---

And I can boot both kernel.

Best Regards,
Hiroaki Fuse

cbe-oss-dev-bounces+hiroaki_fuse=hq.scei.sony.co.jp@ozlabs.org wrote on 
2007/04/05 22:42:21:
> Hi all,
> 
> Benjamin Herrenschmidt and I are proud to announce the first release of
> petitboot - a graphical bootloader for the PS3, based on twin and
> kboot.
> 
> Details (including screenshots) are available at the petitboot homepage:
> 
> http://ozlabs.org/~jk/projects/petitboot/
> 
> Petitboot is still in early development, but we'd be interested in any
> feedback from this beta. There's a TODO list in the tarball if you're
> interested in helping out.
> 
> Feel free to contact Benjamin and/or myself with comments, bugs, or (our
> favourite:) patches.
> 
> Cheers,
> 
> 
> Jeremy
> _______________________________________________
> cbe-oss-dev mailing list
> cbe-oss-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/cbe-oss-dev

--=_alternative 00226017492572BC_=
Content-Type: text/html; charset="us-ascii"


<br><font size=2 face="sans-serif">Jeremy-san,</font>
<br>
<br><font size=2 face="sans-serif">I tried to use petitboot v0.0.1 and found a problem.</font>
<br>
<br><font size=2 face="sans-serif">I use a following kboot.conf.</font>
<br>
<br><font size=2 face="sans-serif">---</font>
<br><font size=2 face="sans-serif">default=linux</font>
<br><font size=2 face="sans-serif">timeout=10</font>
<br><font size=2 face="sans-serif">root=LABEL=/</font>
<br><font size=2 face="sans-serif">linux='/boot/vmlinux-2.6.16 initrd=/boot/initrd.img-2.6.16 '</font>
<br><font size=2 face="sans-serif">linux21='/boot/vmlinux-2.6.21 initrd=/boot/initrd.img-2.6.21 '</font>
<br><font size=2 face="sans-serif">---</font>
<br>
<br><font size=2 face="sans-serif">I saw three entries(root, linux and linux21) and I can not boot any kernel.</font>
<br>
<br><font size=2 face="sans-serif">So I changed my kboot.conf as follows.</font>
<br>
<br><font size=2 face="sans-serif">---</font>
<br><font size=2 face="sans-serif">default=linux</font>
<br><font size=2 face="sans-serif">timeout=10</font>
<br><font size=2 face="sans-serif">linux='/boot/vmlinux-2.6.16 root=LABEL=/ initrd=/boot/initrd.img-2.6.16 '</font>
<br><font size=2 face="sans-serif">linux21='/boot/vmlinux-2.6.21 root=LABEL=/ initrd=/boot/initrd.img-2.6.21 '</font>
<br><font size=2 face="sans-serif">---</font>
<br>
<br><font size=2 face="sans-serif">And I can boot both kernel.</font>
<br>
<br><font size=2 face="sans-serif">Best Regards,</font>
<br><font size=2 face="sans-serif">Hiroaki Fuse</font>
<br>
<br><font size=2 face="sans-serif">cbe-oss-dev-bounces+hiroaki_fuse=hq.scei.sony.co.jp@ozlabs.org wrote on 2007/04/05 22:42:21:<br>
&gt; Hi all,<br>
&gt; <br>
&gt; Benjamin Herrenschmidt and I are proud to announce the first release of<br>
&gt; petitboot - a graphical bootloader for the PS3, based on twin and<br>
&gt; kboot.<br>
&gt; <br>
&gt; Details (including screenshots) are available at the petitboot homepage:<br>
&gt; <br>
&gt; http://ozlabs.org/~jk/projects/petitboot/<br>
&gt; <br>
&gt; Petitboot is still in early development, but we'd be interested in any<br>
&gt; feedback from this beta. There's a TODO list in the tarball if you're<br>
&gt; interested in helping out.<br>
&gt; <br>
&gt; Feel free to contact Benjamin and/or myself with comments, bugs, or (our<br>
&gt; favourite:) patches.<br>
&gt; <br>
&gt; Cheers,<br>
&gt; <br>
&gt; <br>
&gt; Jeremy<br>
&gt; _______________________________________________<br>
&gt; cbe-oss-dev mailing list<br>
&gt; cbe-oss-dev@ozlabs.org<br>
&gt; https://ozlabs.org/mailman/listinfo/cbe-oss-dev<br>
</font>
--=_alternative 00226017492572BC_=--
