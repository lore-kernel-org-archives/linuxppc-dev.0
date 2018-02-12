Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zg48j3jxmzF0X8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 23:04:19 +1100 (AEDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: KVM compile error
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <874lmmwjmc.fsf@concordia.ellerman.id.au>
Date: Mon, 12 Feb 2018 13:04:12 +0100
Cc: linuxppc-dev@lists.ozlabs.org,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
Message-Id: <84E200BC-4202-4BAD-85C2-C8ED6E464FCC@xenosoft.de>
References: <064C3590-DCF8-4764-B0A4-B49310F1AF89@xenosoft.de>
 <874lmmwjmc.fsf@concordia.ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It=E2=80=98s only an info. I tried to compile the latest git version yesterd=
ay and I got this error. I will try to compile the RC1 today and test if thi=
s error still exists.

Cheers,
Christian

Sent from my iPhone

> On 12. Feb 2018, at 12:08, Michael Ellerman <mpe@ellerman.id.au> wrote:
>=20
> Christian Zigotzky <chzigotzky@xenosoft.de> writes:
>=20
>> Just for info: KVM doesn=E2=80=99t compile currently.
>>=20
>> Error messages:
>>=20
>> CC      arch/powerpc/kvm/powerpc.o
>> arch/powerpc/kvm/powerpc.c: In function 'kvm_arch_vcpu_ioctl_run':
>> arch/powerpc/kvm/powerpc.c:1611:1: error: label 'out' defined but not use=
d [-Werror=3Dunused-label]
>> out:
>> ^
>> cc1: all warnings being treated as errors
>=20
> I don't see this, which compiler/config/commit is that?
>=20
> cheers
