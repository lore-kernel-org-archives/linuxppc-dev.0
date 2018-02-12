Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgHzp3XVtzF0pJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 07:57:23 +1100 (AEDT)
Content-Type: multipart/alternative;
 boundary=Apple-Mail-C7289CCF-7238-46B5-84F1-2AB59EE99B5B
Mime-Version: 1.0 (1.0)
Subject: Re: KVM compile error
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <84E200BC-4202-4BAD-85C2-C8ED6E464FCC@xenosoft.de>
Date: Mon, 12 Feb 2018 21:57:15 +0100
Cc: linuxppc-dev@lists.ozlabs.org,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
Message-Id: <33C704AA-9276-4600-94D9-B5403423AE14@xenosoft.de>
References: <064C3590-DCF8-4764-B0A4-B49310F1AF89@xenosoft.de>
 <874lmmwjmc.fsf@concordia.ellerman.id.au>
 <84E200BC-4202-4BAD-85C2-C8ED6E464FCC@xenosoft.de>
To: Michael Ellerman <mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail-C7289CCF-7238-46B5-84F1-2AB59EE99B5B
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Michael,

I compiled the RC1 of kernel 4.16 today. Unfortunately the issue with KVM st=
ill exists.
I get the error 'label out defined but not used' (see error messages below).=


Link to the rc1 kernel config without KVM: http://www.xenosoft.de/cyrus-4.16=
-rc1.config

Link to the git kernel config with KVM: http://www.xenosoft.de/cyrus-4.16-al=
pha10.config

Thanks,
Christian

Sent from my iPhone

> On 12. Feb 2018, at 13:04, Christian Zigotzky <chzigotzky@xenosoft.de> wro=
te:
>=20
> It=E2=80=98s only an info. I tried to compile the latest git version yeste=
rday and I got this error. I will try to compile the RC1 today and test if t=
his error still exists.
>=20
> Cheers,
> Christian
>=20
> Sent from my iPhone
>=20
>> On 12. Feb 2018, at 12:08, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>=20
>> Christian Zigotzky <chzigotzky@xenosoft.de> writes:
>>=20
>>> Just for info: KVM doesn=E2=80=99t compile currently.
>>>=20
>>> Error messages:
>>>=20
>>> CC      arch/powerpc/kvm/powerpc.o
>>> arch/powerpc/kvm/powerpc.c: In function 'kvm_arch_vcpu_ioctl_run':
>>> arch/powerpc/kvm/powerpc.c:1611:1: error: label 'out' defined but not us=
ed [-Werror=3Dunused-label]
>>> out:
>>> ^
>>> cc1: all warnings being treated as errors
>>=20
>> I don't see this, which compiler/config/commit is that?
>>=20
>> cheers
>=20

--Apple-Mail-C7289CCF-7238-46B5-84F1-2AB59EE99B5B
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto">Hello Michael,<div><br></div><div>I compile=
d the RC1 of kernel 4.16 today.&nbsp;<span style=3D"background-color: rgba(2=
55, 255, 255, 0);">Unfortunately the issue with KVM still exists.</span></di=
v><div><span style=3D"background-color: rgba(255, 255, 255, 0);">I get the e=
rror&nbsp;'label out defined but not used' (see error messages below).</span=
></div><div><br></div><div><span style=3D"background-color: rgba(255, 255, 2=
55, 0);">Link to the rc1&nbsp;kernel config without KVM:&nbsp;</span><a href=
=3D"http://www.xenosoft.de/cyrus-4.16-rc1.config">http://www.xenosoft.de/cyr=
us-4.16-rc1.config</a></div><div><br></div><div><span style=3D"background-co=
lor: rgba(255, 255, 255, 0);">Link to the git&nbsp;kernel config with KVM:&n=
bsp;</span><a href=3D"http://www.xenosoft.de/cyrus-4.16-alpha10.config">http=
://www.xenosoft.de/cyrus-4.16-alpha10.config</a></div><div><br></div><div>Th=
anks,</div><div>Christian<br><br><div id=3D"AppleMailSignature">Sent from my=
 iPhone</div><div><br>On 12. Feb 2018, at 13:04, Christian Zigotzky &lt;<a h=
ref=3D"mailto:chzigotzky@xenosoft.de">chzigotzky@xenosoft.de</a>&gt; wrote:<=
br><br></div><blockquote type=3D"cite"><div><span>It=E2=80=98s only an info.=
 I tried to compile the latest git version yesterday and I got this error. I=
 will try to compile the RC1 today and test if this error still exists.</spa=
n><br><span></span><br><span>Cheers,</span><br><span>Christian</span><br><sp=
an></span><br><span>Sent from my iPhone</span><br><span></span><br><blockquo=
te type=3D"cite"><span>On 12. Feb 2018, at 12:08, Michael Ellerman &lt;<a hr=
ef=3D"mailto:mpe@ellerman.id.au">mpe@ellerman.id.au</a>&gt; wrote:</span><br=
></blockquote><blockquote type=3D"cite"><span></span><br></blockquote><block=
quote type=3D"cite"><span>Christian Zigotzky &lt;<a href=3D"mailto:chzigotzk=
y@xenosoft.de">chzigotzky@xenosoft.de</a>&gt; writes:</span><br></blockquote=
><blockquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>Just for info: KVM doesn=E2=80=99t co=
mpile currently.</span><br></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><span>Error messages:</span>=
<br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span></span><br></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span>CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/powerpc=
/kvm/powerpc.o</span><br></blockquote></blockquote><blockquote type=3D"cite"=
><blockquote type=3D"cite"><span>arch/powerpc/kvm/powerpc.c: In function 'kv=
m_arch_vcpu_ioctl_run':</span><br></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span>arch/powerpc/kvm/powerpc.c:1611:1:=
 error: label 'out' defined but not used [-Werror=3Dunused-label]</span><br>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>out:</span><br></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span>^</span><br></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>cc1: all warnings being t=
reated as errors</span><br></blockquote></blockquote><blockquote type=3D"cit=
e"><span></span><br></blockquote><blockquote type=3D"cite"><span>I don't see=
 this, which compiler/config/commit is that?</span><br></blockquote><blockqu=
ote type=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><s=
pan>cheers</span><br></blockquote><span></span><br></div></blockquote></div>=
</body></html>=

--Apple-Mail-C7289CCF-7238-46B5-84F1-2AB59EE99B5B--
