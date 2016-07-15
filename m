Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p04-ob.smtp.rzone.de (mo6-p04-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5304::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrJhc07dWzDqFK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 13:58:39 +1000 (AEST)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: multipart/alternative;
 boundary=Apple-Mail-6356027F-CC5E-40F5-A7DF-B8732452323E
Mime-Version: 1.0 (1.0)
Subject: Problems with prom.h
Message-Id: <234604BD-C89E-4A6A-99DB-B81414FB6104@xenosoft.de>
Date: Fri, 15 Jul 2016 05:52:13 +0200
Cc: info@xenosoft.de
To: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail-6356027F-CC5E-40F5-A7DF-B8732452323E
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi All,

We have problems with some latest stable longterm kernels.
>> I tested the kernel for some hours today. Unfortunately our computers fre=
quently freezes or completely halts with the latest longterm kernels.

- Christian

Sent from my iPhone

> On 15 Jul 2016, at 05:39, Christian Zigotzky <chzigotzky@xenosoft.de> wrot=
e:
>=20
> Hi All,
>=20
> Mechanic reported about the same problems with the stable longterm kernel 3=
.18.37.
>=20
> Link: http://forum.hyperion-entertainment.biz/viewtopic.php?f=3D35&t=3D298=
3&p=3D38389&sid=3D42cf09ed83f7aa590cdac8b7c02eb281#p38389
>=20
> Cheers,
>=20
> Christian
>=20
> Sent from my iPhone
>=20
>> On 14 Jul 2016, at 20:15, Christian Zigotzky <chzigotzky@xenosoft.de> wro=
te:
>>=20
>> Hi All,
>>=20
>> I tried to compile the kernel 4.1.28 today. Unfortunately it didn't compi=
le because of an undeclared variable PPC_FEATURE2_HTM_NOSC_COMP.
>>=20
>> Error message:
>>=20
>>  CHK     include/config/kernel.release
>>  CHK     include/generated/uapi/linux/version.h
>>  CHK     include/generated/utsrelease.h
>>  CHK     include/generated/bounds.h
>>  CHK     include/generated/asm-offsets.h
>>  CALL    scripts/checksyscalls.sh
>>  CHK     include/generated/compile.h
>>  CALL    arch/powerpc/kernel/systbl_chk.sh
>>  CC      arch/powerpc/kernel/prom.o
>> arch/powerpc/kernel/prom.c:170:25: error: 'PPC_FEATURE2_HTM_NOSC_COMP' un=
declared here (not in a function)
>>   PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
>>                         ^
>> make[1]: *** [arch/powerpc/kernel/prom.o] Error 1
>> make: *** [arch/powerpc/kernel] Error 2
>>=20
>> I reported this issue on the Linux ppc mailing list today. After that, Mi=
chael posted a patch because of this issue. Then I compiled the kernel again=
 and I can confirm that the patch works.
>>=20
>> Further information: https://lists.ozlabs.org/pipermail/linuxppc-dev/2016=
-July/145993.html
>>=20
>> I tested the kernel for some hours today. Unfortunately the X1000 frequen=
tly freezes or completely halts with the kernel 4.1.28. That means, I can't r=
elease the kernel 4.1.28.
>>=20
>> If you want to test it then you can download it via the following link: h=
ttp://www.xenosoft.de/vmlinux-4.1.28-AmigaONE_X1000.tar.gz
>>=20
>> I don't know where the problem is in the patches.
>>=20
>> Linux Git log: https://git.kernel.org/cgit/linux/kernel/git/stable/linux-=
stable.git/log/?id=3Drefs/tags/v4.1.28
>>=20
>> ChangeLog: https://cdn.kernel.org/pub/linux/kernel/v4.x/ChangeLog-4.1.28
>>=20
>> Cheers,
>>=20
>> Christian
>>=20
>>=20

--Apple-Mail-6356027F-CC5E-40F5-A7DF-B8732452323E
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><div>Hi All,</div><div id=3D"AppleMailSigna=
ture"><br></div><div id=3D"AppleMailSignature">We have problems with some la=
test stable longterm kernels.</div><div id=3D"AppleMailSignature"><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><font color=3D"#000000"><span styl=
e=3D"background-color: rgba(255, 255, 255, 0);">I tested the kernel for some=
 hours today. Unfortunately our computers frequently freezes or completely h=
alts with the latest longterm kernels.</span></font></blockquote></blockquot=
e><div id=3D"AppleMailSignature"><br></div>- Christian<br><br>Sent from my i=
Phone</div><div><br>On 15 Jul 2016, at 05:39, Christian Zigotzky &lt;<a href=
=3D"mailto:chzigotzky@xenosoft.de">chzigotzky@xenosoft.de</a>&gt; wrote:<br>=
<br></div><blockquote type=3D"cite"><div><meta http-equiv=3D"content-type" c=
ontent=3D"text/html; charset=3Dutf-8"><div>Hi All,</div><div><br></div><div>=
Mechanic reported about the same problems with the stable longterm kernel&nb=
sp;<span style=3D"background-color: rgba(255, 255, 255, 0);">3.18.37.</span>=
</div><div><br></div><div>Link:&nbsp;<a href=3D"http://forum.hyperion-entert=
ainment.biz/viewtopic.php?f=3D35&amp;t=3D2983&amp;p=3D38389&amp;sid=3D42cf09=
ed83f7aa590cdac8b7c02eb281#p38389">http://forum.hyperion-entertainment.biz/v=
iewtopic.php?f=3D35&amp;t=3D2983&amp;p=3D38389&amp;sid=3D42cf09ed83f7aa590cd=
ac8b7c02eb281#p38389</a></div><div><br></div><div>Cheers,</div><div><br></di=
v><div>Christian</div><div><br></div><div><div>Sent from my iPhone</div></di=
v><div><br>On 14 Jul 2016, at 20:15, Christian Zigotzky &lt;<a href=3D"mailt=
o:chzigotzky@xenosoft.de">chzigotzky@xenosoft.de</a>&gt; wrote:<br><br></div=
><blockquote type=3D"cite"><div><span>Hi All,</span><br><span></span><br><sp=
an>I tried to compile the kernel 4.1.28 today. Unfortunately it didn't compi=
le because of an undeclared variable PPC_FEATURE2_HTM_NOSC_COMP.</span><br><=
span></span><br><span>Error message:</span><br><span></span><br><span> &nbsp=
;CHK &nbsp;&nbsp;&nbsp;&nbsp;include/config/kernel.release</span><br><span> &=
nbsp;CHK &nbsp;&nbsp;&nbsp;&nbsp;include/generated/uapi/linux/version.h</spa=
n><br><span> &nbsp;CHK &nbsp;&nbsp;&nbsp;&nbsp;include/generated/utsrelease.=
h</span><br><span> &nbsp;CHK &nbsp;&nbsp;&nbsp;&nbsp;include/generated/bound=
s.h</span><br><span> &nbsp;CHK &nbsp;&nbsp;&nbsp;&nbsp;include/generated/asm=
-offsets.h</span><br><span> &nbsp;CALL &nbsp;&nbsp;&nbsp;scripts/checksyscal=
ls.sh</span><br><span> &nbsp;CHK &nbsp;&nbsp;&nbsp;&nbsp;include/generated/c=
ompile.h</span><br><span> &nbsp;CALL &nbsp;&nbsp;&nbsp;arch/powerpc/kernel/s=
ystbl_chk.sh</span><br><span> &nbsp;CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/po=
werpc/kernel/prom.o</span><br><span>arch/powerpc/kernel/prom.c:170:25: error=
: 'PPC_FEATURE2_HTM_NOSC_COMP' undeclared here (not in a function)</span><br=
><span> &nbsp;&nbsp;PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0,=
 0},</span><br><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;^</span><br><span>make[1]: *** [arch/powerpc/kernel/prom.o] Er=
ror 1</span><br><span>make: *** [arch/powerpc/kernel] Error 2</span><br><spa=
n></span><br><span>I reported this issue on the Linux ppc mailing list today=
. After that, Michael posted a patch because of this issue. Then I compiled t=
he kernel again and I can confirm that the patch works.</span><br><span></sp=
an><br><span>Further information: <a href=3D"https://lists.ozlabs.org/piperm=
ail/linuxppc-dev/2016-July/145993.html">https://lists.ozlabs.org/pipermail/l=
inuxppc-dev/2016-July/145993.html</a></span><br><span></span><br><span>I tes=
ted the kernel for some hours today. Unfortunately the X1000 frequently free=
zes or completely halts with the kernel 4.1.28. That means, I can't release t=
he kernel 4.1.28.</span><br><span></span><br><span>If you want to test it th=
en you can download it via the following link: <a href=3D"http://www.xenosof=
t.de/vmlinux-4.1.28-AmigaONE_X1000.tar.gz">http://www.xenosoft.de/vmlinux-4.=
1.28-AmigaONE_X1000.tar.gz</a></span><br><span></span><br><span>I don't know=
 where the problem is in the patches.</span><br><span></span><br><span>Linux=
 Git log: <a href=3D"https://git.kernel.org/cgit/linux/kernel/git/stable/lin=
ux-stable.git/log/?id=3Drefs/tags/v4.1.28">https://git.kernel.org/cgit/linux=
/kernel/git/stable/linux-stable.git/log/?id=3Drefs/tags/v4.1.28</a></span><b=
r><span></span><br><span>ChangeLog: <a href=3D"https://cdn.kernel.org/pub/li=
nux/kernel/v4.x/ChangeLog-4.1.28">https://cdn.kernel.org/pub/linux/kernel/v4=
.x/ChangeLog-4.1.28</a></span><br><span></span><br><span>Cheers,</span><br><=
span></span><br><span>Christian</span><br><span></span><br><span></span><br>=
</div></blockquote></div></blockquote></body></html>=

--Apple-Mail-6356027F-CC5E-40F5-A7DF-B8732452323E--
