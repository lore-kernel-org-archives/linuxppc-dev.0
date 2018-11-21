Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85059C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 19:02:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B10214D9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 19:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B10214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430X4z60CPzF3bs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 06:02:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=altlinux.org
 (client-ip=194.107.17.57; helo=vmicros1.altlinux.org;
 envelope-from=ldv@altlinux.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=altlinux.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 430X2P3XNbzF3bd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 06:00:12 +1100 (AEDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
 by vmicros1.altlinux.org (Postfix) with ESMTP id 6D78872CC66;
 Wed, 21 Nov 2018 22:00:10 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
 id 5510A7CD20A; Wed, 21 Nov 2018 22:00:10 +0300 (MSK)
Date: Wed, 21 Nov 2018 22:00:10 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v2 16/15] syscall_get_arch: add "struct task_struct *"
 argument
Message-ID: <20181121190009.GA10301@altlinux.org>
References: <20181107042751.3b519062@akathisia>
 <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
 <20181120001128.GA11300@altlinux.org>
 <20181121004422.GA29053@altlinux.org>
 <20181121184004.jro532jopnbmru2m@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20181121184004.jro532jopnbmru2m@pburton-laptop>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, linux-hexagon@vger.kernel.org,
 x86@kernel.org, Eugene Syromyatnikov <esyr@redhat.com>,
 Elvira Khabirova <lineprinter@altlinux.org>,
 linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp,
 linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
 Andy Lutomirski <luto@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, Eric Paris <eparis@redhat.com>,
 linux-audit@redhat.com, linux-alpha@vger.kernel.org,
 nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Wed, Nov 21, 2018 at 06:40:06PM +0000, Paul Burton wrote:
> Hi Dmitry,
>=20
> On Wed, Nov 21, 2018 at 03:44:22AM +0300, Dmitry V. Levin wrote:
> > This argument is required to extend the generic ptrace API
> > with PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going to be
> > called from ptrace_request() along with other syscall_get_* functions
> > with a tracee as their argument.
> >=20
> > This change partially reverts commit 5e937a9ae913 ("syscall_get_arch:
> > remove useless function arguments").
> >=20
> >%
> >=20
> > diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/sy=
scall.h
> > index 0170602a1e4e..52b633f20abd 100644
> > --- a/arch/mips/include/asm/syscall.h
> > +++ b/arch/mips/include/asm/syscall.h
> > @@ -73,7 +73,7 @@ static inline unsigned long mips_get_syscall_arg(unsi=
gned long *arg,
> >  #ifdef CONFIG_64BIT
> >  	case 4: case 5: case 6: case 7:
> >  #ifdef CONFIG_MIPS32_O32
> > -		if (test_thread_flag(TIF_32BIT_REGS))
> > +		if (test_ti_thread_flag(task_thread_info(task), TIF_32BIT_REGS))
> >  			return get_user(*arg, (int *)usp + n);
> >  		else
> >  #endif
>=20
> This ought to be test_tsk_thread_flag(task, TIF_32BIT_REGS) instead of
> open-coding test_tsk_thread_flag.

This will be corrected, thanks for letting me know.

> More fundamentally though, this change doesn't seem to be (directly)
> related to the change you describe in the commit message - it's not
> syscall_get_arch being modified here. I suspect this should be a
> separate commit, or if not please explain in the commit message why this
> change is included.

Good point, this is a fix that should not have been included into this comm=
it.
The bug was found while preparing the syscall_get_arch change, and this
hunk just slipped in.  I'll send it as a separate commit.

> Compounding the lack of clarity is the fact that I only received this
> patch, not the whole series, so I can't view the change in the context
> of the rest of the series.
>=20
> > @@ -140,14 +140,14 @@ extern const unsigned long sys_call_table[];
> >  extern const unsigned long sys32_call_table[];
> >  extern const unsigned long sysn32_call_table[];
> > =20
> > -static inline int syscall_get_arch(void)
> > +static inline int syscall_get_arch(struct task_struct *task)
> >  {
> >  	int arch =3D AUDIT_ARCH_MIPS;
> >  #ifdef CONFIG_64BIT
> > -	if (!test_thread_flag(TIF_32BIT_REGS)) {
> > +	if (!test_ti_thread_flag(task_thread_info(task), TIF_32BIT_REGS)) {
> >  		arch |=3D __AUDIT_ARCH_64BIT;
> >  		/* N32 sets only TIF_32BIT_ADDR */
> > -		if (test_thread_flag(TIF_32BIT_ADDR))
> > +		if (test_ti_thread_flag(task_thread_info(task), TIF_32BIT_ADDR))
> >  			arch |=3D __AUDIT_ARCH_CONVENTION_MIPS64_N32;
> >  	}
> >  #endif
>=20
> This does seem like the described change, but there are 2 more instances
> of open-coding test_tsk_thread_flag which ought to be cleaned up.

This will be cleaned up, thanks for letting me know.


--=20
ldv

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJb9as5AAoJEAVFT+BVnCUIMwEQAK/kFQPbOlZh1qWyjUznc+u9
B2U2LJjbOkYfYnr9QwrWQpg/TjvxgUN35dpVOsv/im0GsqFEY2Rzc7tI70ENrEeU
q6QXC13R/sIvKRDMEzNyZRaXhHsc0KAhq7LolCTAxeK8t/Fv5Zz9j3TJFWQ9DwDz
NVDn67xoF2I1U1grwrJFrOrmPTr3B0jQKGekfMwoj+efsP09U8U6mOAbJ4WF3DW4
zJXbMREy/PNA4g/usZzp0ckgLrceTql83DdogIPaCytZrDNteKgXgGUW/MPCty1C
4hWReW1CumdXr9ULf2cbiwrvBnG+Sa9lN2QTeaIH892Ln9sToAfRX2D1YMH5mfcP
FDHeP0jpZgLqXmiiAVVXXV1Al2DnAR3ohZlmyRyT06thhiVWptG/KjrgcRM3G9hZ
vVzvRv8kBaj+6WzpW+hS97lHeqbg3s0AMBTy8rWaLyGJMUUAUQ0jOcN3faZbegI6
L7AsGZiHRxjLIwuXIRh93/rPrmyWbY9zli4BDaufbvYRiJK3TYyEBeQB95X6mmiA
DuUIR5hOaMafxWExgknG1NRuBnrhmpkokyvEAClQyg7zvWflHMOd9trQJXFfSKI8
A3e+hTMBRs9HXfqdXe9QUj6f7pQIpRh3xSXKyePA1kFj6DuJMe+dLKQGQEeCE1bf
pqgRdoGWKyibD9iR9c1/
=hLdr
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
