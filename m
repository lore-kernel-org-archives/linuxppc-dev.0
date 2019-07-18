Return-Path: <SRS0=Nz1t=VP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453CEC7618F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jul 2019 15:24:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3F420880
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jul 2019 15:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3F420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45qHx726pJzDqbB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 01:24:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cyphar.com
 (client-ip=80.241.60.212; helo=mx1.mailbox.org;
 envelope-from=cyphar@cyphar.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=cyphar.com
Received: from mx1.mailbox.org (mx1.mailbox.org [80.241.60.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45qHtn4pyjzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2019 01:22:22 +1000 (AEST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:105:465:1:2:0])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested)
 by mx1.mailbox.org (Postfix) with ESMTPS id A31DB4DF37;
 Thu, 18 Jul 2019 17:22:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
 by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172])
 (amavisd-new, port 10030)
 with ESMTP id xmIYYji9PWVu; Thu, 18 Jul 2019 17:22:09 +0200 (CEST)
Date: Fri, 19 Jul 2019 01:21:23 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v9 08/10] open: openat2(2) syscall
Message-ID: <20190718152123.m33t44dapy6y4nwy@yavin>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-9-cyphar@cyphar.com>
 <845e4364-685f-343b-46fb-c418766dce3e@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x55cx7xfpotu25go"
Content-Disposition: inline
In-Reply-To: <845e4364-685f-343b-46fb-c418766dce3e@rasmusvillemoes.dk>
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, linux-kselftest@vger.kernel.org,
 sparclinux@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Tycho Andersen <tycho@tycho.ws>, Aleksa Sarai <asarai@suse.de>,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
 Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, David Drysdale <drysdale@google.com>,
 Christian Brauner <christian@brauner.io>,
 "J. Bruce Fields" <bfields@fieldses.org>, linux-parisc@vger.kernel.org,
 linux-api@vger.kernel.org, Chanho Min <chanho.min@lge.com>,
 Jeff Layton <jlayton@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, linux-alpha@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 containers@lists.linux-foundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--x55cx7xfpotu25go
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-18, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> On 06/07/2019 16.57, Aleksa Sarai wrote:
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -928,24 +928,32 @@ struct file *open_with_fake_path(const struct pat=
h *path, int flags,
> >  }
> >  EXPORT_SYMBOL(open_with_fake_path);
> > =20
> > -static inline int build_open_flags(int flags, umode_t mode, struct ope=
n_flags *op)
> > +static inline int build_open_flags(struct open_how how, struct open_fl=
ags *op)
> >  {
>=20
> How does passing such a huge struct by value affect code generation?
> Does gcc actually inline the function (and does it even inline the old
> one given that it's already non-trivial and has more than one caller).

I'm not sure, but I'll just do what you suggested with passing a const
reference and just copying the few fields that actually are touched by
this function.

> > =20
> > diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> > index 2868ae6c8fc1..e59917292213 100644
> > --- a/include/linux/fcntl.h
> > +++ b/include/linux/fcntl.h
> > @@ -4,13 +4,26 @@
> > =20
> >  #include <uapi/linux/fcntl.h>
> > =20
> > -/* list of all valid flags for the open/openat flags argument: */
> > +/* Should open_how.mode be set for older syscalls wrappers? */
> > +#define OPENHOW_MODE(flags, mode) \
> > +	(((flags) | (O_CREAT | __O_TMPFILE)) ? (mode) : 0)
> > +
>=20
> Typo: (((flags) & (O_CREAT | __O_TMPFILE)) ? (mode) : 0)

Yup, thanks. I'm not sure why my tests passed on v9 with this bug (they
didn't pass in my v10-draft until I fixed this bug earlier today).

>=20
> > +/**
> > + * Arguments for how openat2(2) should open the target path. If @extra=
 is zero,
> > + * then openat2(2) is identical to openat(2).
> > + *
> > + * @flags: O_* flags (unknown flags ignored).
> > + * @mode: O_CREAT file mode (ignored otherwise).
>=20
> should probably say "O_CREAT/O_TMPFILE file mode".

:+1:

> > + * @upgrade_mask: restrict how the O_PATH may be re-opened (ignored ot=
herwise).
> > + * @resolve: RESOLVE_* flags (-EINVAL on unknown flags).
> > + * @reserved: reserved for future extensions, must be zeroed.
> > + */
> > +struct open_how {
> > +	__u32 flags;
> > +	union {
> > +		__u16 mode;
> > +		__u16 upgrade_mask;
> > +	};
> > +	__u16 resolve;
>=20
> So mode and upgrade_mask are naturally u16 aka mode_t. And yes, they
> probably never need to be used together, so the union works. That then
> makes the next member 2-byte aligned, so using a u16 for the resolve
> flags brings us to an 8-byte boundary, and 11 unused flag bits should be
> enough for a while. But it seems a bit artificial to cram all this
> together and then add 56 bytes of reserved space.

I will happily admit that padding to 64 bytes is probably _very_ extreme
(I picked it purely because it's the size of a cache-line so anything
bigger makes even less sense). I was hoping someone would suggest a
better size once I posted the patchset, since I couldn't think of a good
answer myself.

Do you have any suggestions for a better layout or padding size?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--x55cx7xfpotu25go
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXTCOcAAKCRCdlLljIbnQ
EllZAP4qSUDEVdU4aP8+s9uysbQoCi6l463vJM+jdHxpJ66OfQEAxlI5lXwcL6G0
jPCtI0Vs5LI5kpJuE2k98ol8BVMyZAg=
=2lKS
-----END PGP SIGNATURE-----

--x55cx7xfpotu25go--
