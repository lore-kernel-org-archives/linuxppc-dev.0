Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 77545DE8B6
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 01:37:27 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so1065338pyi.27
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 08:37:25 -0700 (PDT)
Message-ID: <319b0ac50808250837r73d88349p1ecad4214d5f7ae3@mail.gmail.com>
Date: Mon, 25 Aug 2008 17:37:25 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: initramfs vs initrd
In-Reply-To: <319b0ac50808250729i2043c4d6h57577e0a2eda7ed8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_13388_24653994.1219678645056"
References: <319b0ac50808250557g4bd1d267t14e3bd8887c76e24@mail.gmail.com>
	<20080825131018.GA4199@yoda.jdub.homelinux.org>
	<319b0ac50808250729i2043c4d6h57577e0a2eda7ed8@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_13388_24653994.1219678645056
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

When the kernel is booting, is it possible to check if the initrd is good ?

2008/8/25, S=E9bastien Chr=E9tien <sebastien.chretien.enseirb@gmail.com>:
>
> ok thank you
>
>
>
> 2008/8/25, Josh Boyer <jwboyer@linux.vnet.ibm.com>:
>>
>> On Mon, Aug 25, 2008 at 02:57:14PM +0200,
>> =3D?ISO-8859-1?Q?S=3DE9bastien_Chr=3DE9tien_ wrote:
>> >Hello,
>> >
>> >What is the difference between initramfs and initrd ?
>>
>>
>> You could poke around in the Documentation directory of the kernel.  Tha=
t
>> should answer your question.
>>
>> Briefly, initramfs is a gzipped cpio archive.  initrd is typically a
>> compressed ext2 filesystem and requires a ramdisk to be unpacked to.
>>
>> josh
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
>
>

------=_Part_13388_24653994.1219678645056
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

When the kernel is booting, is it possible to check if the initrd is good ?=
<br><br><div><span class=3D"gmail_quote">2008/8/25, S=E9bastien Chr=E9tien =
&lt;<a href=3D"mailto:sebastien.chretien.enseirb@gmail.com">sebastien.chret=
ien.enseirb@gmail.com</a>&gt;:</span><blockquote class=3D"gmail_quote" styl=
e=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; =
padding-left: 1ex;">
ok thank you<br>
<br>
<br>
<br><div><span class=3D"gmail_quote">2008/8/25, Josh Boyer &lt;<a href=3D"m=
ailto:jwboyer@linux.vnet.ibm.com" target=3D"_blank" onclick=3D"return top.j=
s.OpenExtLink(window,event,this)">jwboyer@linux.vnet.ibm.com</a>&gt;:</span=
><div>
<span class=3D"e" id=3D"q_11bfa4533d1145ea_1"><blockquote class=3D"gmail_qu=
ote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0p=
t 0.8ex; padding-left: 1ex;">
On Mon, Aug 25, 2008 at 02:57:14PM +0200, =3D?ISO-8859-1?Q?S=3DE9bastien_Ch=
r=3DE9tien_ wrote:<br> &gt;Hello,<br> &gt;<br> &gt;What is the difference b=
etween initramfs and initrd ?<br> <br> <br>You could poke around in the Doc=
umentation directory of the kernel.&nbsp;&nbsp;That<br>

 should answer your question.<br> <br> Briefly, initramfs is a gzipped cpio=
 archive.&nbsp;&nbsp;initrd is typically a<br> compressed ext2 filesystem a=
nd requires a ramdisk to be unpacked to.<br> <br> josh<br> ________________=
_______________________________<br>

 Linuxppc-dev mailing list<br> <a href=3D"mailto:Linuxppc-dev@ozlabs.org" t=
arget=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">L=
inuxppc-dev@ozlabs.org</a><br> <a href=3D"https://ozlabs.org/mailman/listin=
fo/linuxppc-dev" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(win=
dow,event,this)">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
 </blockquote>
</span></div></div><br>
</blockquote></div><br>

------=_Part_13388_24653994.1219678645056--
