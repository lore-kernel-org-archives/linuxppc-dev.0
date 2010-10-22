Return-Path: <tosubrata@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id 00310B70CD
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Oct 2010 06:05:00 +1100 (EST)
Received: by wyb35 with SMTP id 35so1711788wyb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Oct 2010 12:04:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CC13FFF.7040200@linux.vnet.ibm.com>
References: <4CC13B2C.7090908@linux.vnet.ibm.com>
	<4CC13FFF.7040200@linux.vnet.ibm.com>
Date: Sat, 23 Oct 2010 00:34:58 +0530
Message-ID: <AANLkTim7ep+xdp-rwExf_ZjZ97z-8sN0-nx4sxmZ7wVF@mail.gmail.com>
Subject: Re: BUG with the kernel version 2.6.36-rc1 on power machine
From: Subrata Modak <tosubrata@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cdff81e9a0c400493395177
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	divya <dipraksh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cdff81e9a0c400493395177
Content-Type: text/plain; charset=UTF-8

This is seen equally on Power6 & Power7 systems.

Regards--
Subrata

On Fri, Oct 22, 2010 at 1:10 PM, divya <dipraksh@linux.vnet.ibm.com> wrote:

> On Friday 22 October 2010 12:50 PM, divya wrote:
>
>> Hi ,
>>
>> With the latest version of kernel 2.6.36-rc1 running on the power machine,
>> came across the following call trace
>>
>> BUG: looking up invalid subclass: 31
>> turning off the locking correctness validator.
>> Call Trace:
>> [c00000000e0bfb60] [c0000000000119a0] .show_stack+0x6c/0x16c (unreliable)
>> [c00000000e0bfc10] [c0000000000c39b8] .lockdep_init_map+0x194/0x630
>> [c00000000e0bfcf0] [c0000000005524f8] .mousedev_create+0xcc/0x234
>> [c00000000e0bfda0] [c00000000093fb58] .mousedev_init+0x38/0xa0
>> [c00000000e0bfe30] [c0000000000097e4] .do_one_initcall+0xd8/0x1c8
>> [c00000000e0bfee0] [c0000000009004ac] .kernel_init+0x23c/0x2f8
>> [c00000000e0bff90] [c00000000002ad30] .kernel_thread+0x54/0x70
>>
>> The config file used for make oldconfig is being attached
>>
>> Thanks
>> Divya
>>
>>
>>
>>
>>  I meant 2.6.36-git1(b5153163ed580e) , and not 2.6.36-rc1.
> Sorry for the confusion.
>
> Thanks
> Divya
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



-- 
Regards & Thanks--
Subrata

--000e0cdff81e9a0c400493395177
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This is seen equally on Power6 &amp; Power7 systems.<br><br>Regards--<br>Su=
brata<br><br><div class=3D"gmail_quote">On Fri, Oct 22, 2010 at 1:10 PM, di=
vya <span dir=3D"ltr">&lt;<a href=3D"mailto:dipraksh@linux.vnet.ibm.com">di=
praksh@linux.vnet.ibm.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"h5">On Friday 22 October 2010 12:50 PM, divya wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi ,<br>
<br>
With the latest version of kernel 2.6.36-rc1 running on the power machine, =
came across the following call trace<br>
<br>
BUG: looking up invalid subclass: 31<br>
turning off the locking correctness validator.<br>
Call Trace:<br>
[c00000000e0bfb60] [c0000000000119a0] .show_stack+0x6c/0x16c (unreliable)<b=
r>
[c00000000e0bfc10] [c0000000000c39b8] .lockdep_init_map+0x194/0x630<br>
[c00000000e0bfcf0] [c0000000005524f8] .mousedev_create+0xcc/0x234<br>
[c00000000e0bfda0] [c00000000093fb58] .mousedev_init+0x38/0xa0<br>
[c00000000e0bfe30] [c0000000000097e4] .do_one_initcall+0xd8/0x1c8<br>
[c00000000e0bfee0] [c0000000009004ac] .kernel_init+0x23c/0x2f8<br>
[c00000000e0bff90] [c00000000002ad30] .kernel_thread+0x54/0x70<br>
<br>
The config file used for make oldconfig is being attached<br>
<br>
Thanks<br>
Divya<br>
<br>
<br>
<br>
<br>
</blockquote></div></div>
I meant 2.6.36-git1(b5153163ed580e) , and not 2.6.36-rc1.<br>
Sorry for the confusion.<br>
<br>
Thanks<br>
Divya<br><font color=3D"#888888">
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org" targe=
t=3D"_blank">majordomo@vger.kernel.org</a><br>
More majordomo info at =C2=A0<a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
Please read the FAQ at =C2=A0<a href=3D"http://www.tux.org/lkml/" target=3D=
"_blank">http://www.tux.org/lkml/</a><br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Regards &amp; Th=
anks--<br>Subrata<br>

--000e0cdff81e9a0c400493395177--
