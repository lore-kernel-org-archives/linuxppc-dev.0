Return-Path: <SRS0=9qWD=TP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9886C04E53
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 22:09:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15EFC2084F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 22:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EFC2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4547xn62pCzDqbh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 May 2019 08:09:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cyphar.com
 (client-ip=2001:67c:2050:104:0:2:25:2; helo=mx2.mailbox.org;
 envelope-from=cyphar@cyphar.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=cyphar.com
Received: from mx2.mailbox.org (unknown [IPv6:2001:67c:2050:104:0:2:25:2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4547j46xGwzDqWT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2019 07:58:16 +1000 (AEST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:105:465:1:1:0])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested)
 by mx2.mailbox.org (Postfix) with ESMTPS id 36D13A1145;
 Wed, 15 May 2019 16:51:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
 by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de
 [80.241.56.115]) (amavisd-new, port 10030)
 with ESMTP id X8vroVdtsNp3; Wed, 15 May 2019 16:51:23 +0200 (CEST)
Date: Thu, 16 May 2019 00:51:05 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 1/2] pid: add pidfd_open()
Message-ID: <20190515145105.t7u6v5wxsq2tnbwj@yavin>
References: <20190515100400.3450-1-christian@brauner.io>
 <4c5ae46657e1931a832def5645db61eb0bf1accd.camel@opteya.com>
 <20190515141634.lrc5ynllcmjr64mn@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2zvewrqzesizclxu"
Content-Disposition: inline
In-Reply-To: <20190515141634.lrc5ynllcmjr64mn@brauner.io>
X-Mailman-Approved-At: Thu, 16 May 2019 08:08:06 +1000
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
 linux-kernel@vger.kernel.org, dhowells@redhat.com,
 linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-api@vger.kernel.org, elena.reshetova@intel.com,
 Yann Droneaud <ydroneaud@opteya.com>, linux-s390@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 keescook@chromium.org, arnd@arndb.de, jannh@google.com,
 linux-m68k@lists.linux-m68k.org, viro@zeniv.linux.org.uk, luto@kernel.org,
 oleg@redhat.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, torvalds@linux-foundation.org,
 linux-mips@vger.kernel.org, luto@amacapital.net, ebiederm@xmission.com,
 linux-alpha@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--2zvewrqzesizclxu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-15, Christian Brauner <christian@brauner.io> wrote:
> On Wed, May 15, 2019 at 04:00:20PM +0200, Yann Droneaud wrote:
> > Would it be possible to create file descriptor with "restricted"
> > operation ?
> >=20
> > - O_RDONLY: waiting for process completion allowed (for example)
> > - O_WRONLY: sending process signal allowed
>=20
> Yes, something like this is likely going to be possible in the future.
> We had discussion around this. But mapping this to O_RDONLY and O_WRONLY
> is not the right model. It makes more sense to have specialized flags
> that restrict actions.

Not to mention that the O_* flags have silly values which we shouldn't
replicate in new syscalls IMHO.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--2zvewrqzesizclxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlzcJ1kACgkQSnvnv3De
m5+m3g//R5zkvJNpR/uERo7fQzZ+8FbxYCxRtilFUHcBIdsgV/Lx50jsUxWug4Zl
9r3C4jToLLKtMADwKihJR+E1ftE2STZ85hvLL0wpKX2kUqQcby7sU+XqgAFDuFXe
eJLnHxTbErqrqcU8Qz1+0nTAxiPcekV2c7jB1+jQtFvakcqlxaT2CtK2/7P3sw2P
G8mLXOL8uRx2WQ4z94SwfQ4kFwx14SIfWOA3kXVCDsuOoisQBqFsq9WhTwVsTb1X
H9KRNF58YIjBkWTVe3VcJZiVKXfqZxYbZDhHSQiibqyFZ3JkBjeo+FS9xoGqCNkl
I1M/BRHkyfhy1fIA8sIq82Bf1XXj4gaunsAk26xJqdpNnwUzXLT9IqXB/cD+D0+/
v6SzkNckMf/igucg6Ev9n8Z+Asst7aTfDLkrtPubFrYsD8FjgsU7xqMlN5lnVMx3
ovXX+xt0yRgVaczFTA0oWlc316Cje3SfchGc5dYce1BdsM98UaveoFKqsZ2QFyA7
sHNClAFebnAGwYAcOAWgz4dU+B2YmDv1Z1xJ52IyGcPo4KGXYBfY9X3J+rIXTLhc
0qp7vr8JIII/pSDquixjtG+aI+eLtl0g72mUM1KlOGDJZhQG14VRasjEI1M098Fk
GRGn0Y2fOWPigwhq0zRKpIIp2d3YXZY8TamkTEMXPY3azLq50Jk=
=+Ix9
-----END PGP SIGNATURE-----

--2zvewrqzesizclxu--
