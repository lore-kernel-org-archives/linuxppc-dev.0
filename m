Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B66BC4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 18:19:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE7E206B7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 18:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE7E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Zrnx3Tr7zDqRf
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 05:19:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=altlinux.org
 (client-ip=194.107.17.57; helo=vmicros1.altlinux.org;
 envelope-from=ldv@altlinux.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=altlinux.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 44Zrlx3KvHzDqPy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 05:18:03 +1100 (AEDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
 by vmicros1.altlinux.org (Postfix) with ESMTP id E9BF372CC8C;
 Thu,  4 Apr 2019 21:17:58 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
 id D67DD7CCE4F; Thu,  4 Apr 2019 21:17:58 +0300 (MSK)
Date: Thu, 4 Apr 2019 21:17:58 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 5/6 v3] syscalls: Remove start and number from
 syscall_get_arguments() args
Message-ID: <20190404181758.GA8071@altlinux.org>
References: <20190401134104.676620247@goodmis.org>
 <20190401134421.278590567@goodmis.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20190401134421.278590567@goodmis.org>
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
Cc: linux-ia64@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Peter Zijlstra <peterz@infradead.org>, Palmer Dabbelt <palmer@sifive.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Oleg Nesterov <oleg@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org,
 Dave Martin <dave.martin@arm.com>, uclinux-h8-devel@lists.sourceforge.jp,
 linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
 Roland McGrath <roland@hack.frob.com>, linux-um@lists.infradead.org,
 linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 "Eric W. Biederman" <ebiederm@xmission.com>, nios2-dev@lists.rocketboards.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 09:41:09AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
>=20
> At Linux Plumbers, Andy Lutomirski approached me and pointed out that the
> function call syscall_get_arguments() implemented in x86 was horribly
> written and not optimized for the standard case of passing in 0 and 6 for
> the starting index and the number of system calls to get. When looking at
> all the users of this function, I discovered that all instances pass in o=
nly
> 0 and 6 for these arguments. Instead of having this function handle
> different cases that are never used, simply rewrite it to return the firs=
t 6
> arguments of a system call.
>=20
> This should help out the performance of tracing system calls by ptrace,
> ftrace and perf.
>=20
> Link: http://lkml.kernel.org/r/20161107213233.754809394@goodmis.org

FWIW, you can add
Reviewed-by: Dmitry V. Levin <ldv@altlinux.org>

There are several places listed below where I'd prefer to see more readable
equivalents, but feel free to leave it to respective arch maintainers.

> diff --git a/arch/hexagon/include/asm/syscall.h b/arch/hexagon/include/as=
m/syscall.h
> index 4af9c7b6f13a..ae3a1e24fabd 100644
> --- a/arch/hexagon/include/asm/syscall.h
> +++ b/arch/hexagon/include/asm/syscall.h
> @@ -37,10 +37,8 @@ static inline long syscall_get_nr(struct task_struct *=
task,
> =20
>  static inline void syscall_get_arguments(struct task_struct *task,
>  					 struct pt_regs *regs,
> -					 unsigned int i, unsigned int n,
>  					 unsigned long *args)
>  {
> -	BUG_ON(i + n > 6);
> -	memcpy(args, &(&regs->r00)[i], n * sizeof(args[0]));
> +	memcpy(args, &(&regs->r00)[0], 6 * sizeof(args[0]));

A shorter and slightly more readable equivalent is

	memcpy(args, &regs->r00, 6 * sizeof(args[0]));

> diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/sy=
scall.h
> index f7e5e86765fe..89a6ec8731d8 100644
> --- a/arch/nds32/include/asm/syscall.h
> +++ b/arch/nds32/include/asm/syscall.h
> @@ -108,42 +108,21 @@ void syscall_set_return_value(struct task_struct *t=
ask, struct pt_regs *regs,
>   * syscall_get_arguments - extract system call parameter values
>   * @task:	task of interest, must be blocked
>   * @regs:	task_pt_regs() of @task
> - * @i:		argument index [0,5]
> - * @n:		number of arguments; n+i must be [1,6].
>   * @args:	array filled with argument values
>   *
> - * Fetches @n arguments to the system call starting with the @i'th argum=
ent
> - * (from 0 through 5).  Argument @i is stored in @args[0], and so on.
> - * An arch inline version is probably optimal when @i and @n are constan=
ts.
> + * Fetches 6 arguments to the system call (from 0 through 5). The first
> + * argument is stored in @args[0], and so on.
>   *
>   * It's only valid to call this when @task is stopped for tracing on
>   * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUD=
IT.
> - * It's invalid to call this with @i + @n > 6; we only support system ca=
lls
> - * taking up to 6 arguments.
>   */
>  #define SYSCALL_MAX_ARGS 6
>  void syscall_get_arguments(struct task_struct *task, struct pt_regs *reg=
s,
> -			   unsigned int i, unsigned int n, unsigned long *args)
> +			   unsigned long *args)
>  {
> -	if (n =3D=3D 0)
> -		return;
> -	if (i + n > SYSCALL_MAX_ARGS) {
> -		unsigned long *args_bad =3D args + SYSCALL_MAX_ARGS - i;
> -		unsigned int n_bad =3D n + i - SYSCALL_MAX_ARGS;
> -		pr_warning("%s called with max args %d, handling only %d\n",
> -			   __func__, i + n, SYSCALL_MAX_ARGS);
> -		memset(args_bad, 0, n_bad * sizeof(args[0]));
> -		memset(args_bad, 0, n_bad * sizeof(args[0]));
> -	}
> -
> -	if (i =3D=3D 0) {
> -		args[0] =3D regs->orig_r0;
> -		args++;
> -		i++;
> -		n--;
> -	}
> -
> -	memcpy(args, &regs->uregs[0] + i, n * sizeof(args[0]));
> +	args[0] =3D regs->orig_r0;
> +	args++;
> +	memcpy(args, &regs->uregs[0] + 1, 5 * sizeof(args[0]));
>  }

A shorter and slightly more readable equivalent of the last memcpy is

	memcpy(args, &regs->uregs[1], 5 * sizeof(args[0]));

> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/as=
m/syscall.h
> index 1a0e7a8b1c81..5c9b9dc82b7e 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -65,22 +65,20 @@ static inline void syscall_set_return_value(struct ta=
sk_struct *task,
> =20
>  static inline void syscall_get_arguments(struct task_struct *task,
>  					 struct pt_regs *regs,
> -					 unsigned int i, unsigned int n,
>  					 unsigned long *args)
>  {
>  	unsigned long val, mask =3D -1UL;
> -
> -	BUG_ON(i + n > 6);
> +	unsigned int n =3D 6;
> =20
>  #ifdef CONFIG_COMPAT
>  	if (test_tsk_thread_flag(task, TIF_32BIT))
>  		mask =3D 0xffffffff;
>  #endif
>  	while (n--) {
> -		if (n =3D=3D 0 && i =3D=3D 0)
> +		if (n =3D=3D 0)
>  			val =3D regs->orig_gpr3;
>  		else
> -			val =3D regs->gpr[3 + i + n];
> +			val =3D regs->gpr[3 + n];
> =20
>  		args[n] =3D val & mask;
>  	}

A shorter and slightly more readable equivalent of the loop is

	while (--n)
		args[n] =3D regs->gpr[3 + n] & mask;
	args[0] =3D regs->orig_gpr3 & mask;

> diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/sysc=
all.h
> index 96f9a9151fde..ee0b1f6aa36d 100644
> --- a/arch/s390/include/asm/syscall.h
> +++ b/arch/s390/include/asm/syscall.h
> @@ -56,27 +56,20 @@ static inline void syscall_set_return_value(struct ta=
sk_struct *task,
> =20
>  static inline void syscall_get_arguments(struct task_struct *task,
>  					 struct pt_regs *regs,
> -					 unsigned int i, unsigned int n,
>  					 unsigned long *args)
>  {
>  	unsigned long mask =3D -1UL;
> +	unsigned int n =3D 6;
> =20
> -	/*
> -	 * No arguments for this syscall, there's nothing to do.
> -	 */
> -	if (!n)
> -		return;
> -
> -	BUG_ON(i + n > 6);
>  #ifdef CONFIG_COMPAT
>  	if (test_tsk_thread_flag(task, TIF_31BIT))
>  		mask =3D 0xffffffff;
>  #endif
>  	while (n-- > 0)
> -		if (i + n > 0)
> -			args[n] =3D regs->gprs[2 + i + n] & mask;
> -	if (i =3D=3D 0)
> -		args[0] =3D regs->orig_gpr2 & mask;
> +		if (n > 0)
> +			args[n] =3D regs->gprs[2 + n] & mask;
> +
> +	args[0] =3D regs->orig_gpr2 & mask;

A shorter and slightly more readable equivalent of the loop is

	while (--n > 0)
		args[n] =3D regs->gprs[2 + n] & mask;


--=20
ldv

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcpkpWAAoJEAVFT+BVnCUIlOcP/j1eQljKOX/AHCJT/5vQfVVN
eBtqUihrrz/8PY+hMxpVM5CvZkpiLHBxyU4Ne/XM8v93bpx89F/XfOlFTpA0td0C
xVr0GFbsF4zNH9bf4b6MI8Ku2kfpsYYVno1hWtsJ2QlYUgOOzTEVzszkeewOWHD1
Cb/yYyjDwKDFDa83WU5CDCyJ/XNo1o75wolhPWgkVnRRJ9+wosg9xh0KnzY9z1zP
Pp53uQFQXvMZBw+Onobz1j2EGHJNxPjr7fnOIbrqlcavgItvieUkBxvQ/2qQ+tOe
88+okvF5TvKLAmlSXXYll8MAhxW5usbCe5sBgz3VXVtJ508j1bt0StivFSPQyGeV
OQI75cxqalLtgN00NZpaU7tQci/XOFB0GKupRn2Jd3RHyvxtlD64RLpOLfYCtuq2
CJmpVB2WeuHzQ2e7lmX0jUJazjzk7HPTOPl+YJ6FudHdSXwX9RirrkPonb1kyHl6
jhp4TLUvuTlFUUfNgt7YmuTj9+mg1Px5ocVshpQ9jp9w64RQWim8wn1wzgJxvMk1
0/xN1xOkv5TV1T4icCsiJHpu0iwA1Nok3sumZJ68ohFDS8ompd8aN1+f0dBTRXB1
xboVMcH+OkNHae897yWu8WdjvBCGohVADUvE2rqWKrJPniL09WStw8ie5MOOHiC+
L1wTLatEoUOlg4wAp6No
=0pXz
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
