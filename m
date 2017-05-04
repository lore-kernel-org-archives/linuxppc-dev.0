Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJfcP2nD2zDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 01:50:12 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: "'pc@us.ibm.com'" <pc@us.ibm.com>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>
Subject: RE: [PATCH v2] powerpc/kprobes: refactor kprobe_lookup_name for
 safer string operations
Date: Thu, 4 May 2017 15:50:06 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFE568C@AcuExch.aculab.com>
References: <20170504102452.9701-1-naveen.n.rao@linux.vnet.ibm.com>
 <0895bcf8-f06b-98b8-265c-bc5bcc2057f1@us.ibm.com>
In-Reply-To: <0895bcf8-f06b-98b8-265c-bc5bcc2057f1@us.ibm.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Clarke
> Sent: 04 May 2017 16:07
...
> > +	if ((c =3D strnchr(name, MODULE_NAME_LEN, ':')) !=3D NULL) {
>=20
> Shouldn't this be MODULE_NAME_LEN + 1, since the ':' can come after a mod=
ule name of length
> MODULE_NAME_LEN?

No, because MODULE_NAME_LEN includes the terminating '\0'.

	David
