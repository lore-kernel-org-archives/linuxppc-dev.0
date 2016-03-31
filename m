Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbbQ11F6pzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 07:16:40 +1100 (AEDT)
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 31 Mar 2016 17:16:36 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id A67431DC0070
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 16:16:28 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2VJEIm35071052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 16:14:18 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2VKGXB7003060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 17:16:33 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Remove kretprobe_trampoline_holder.
Date: Thu, 31 Mar 2016 17:16:30 -0300
Message-ID: <3165647.AEF6NlnZx5@hactar>
In-Reply-To: <20160331082311.GA17907@naverao1-tp.ibm.com>
References: <3qWbvb0yVwz9sdm@ozlabs.org>
 <1459195592-6559-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160331082311.GA17907@naverao1-tp.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Donnerstag, 31 M=C3=A4rz 2016, 13:53:11 schrieb Naveen N. Rao:
> You should indent the above output -- in this specific case, the star=
t
> marker interferes with git am.
>=20
> Apart from that, I have tested this patch and kretprobe works fine. A=

> minor nit I had is that we end up with a non-dot function in .text
> without a corresponding function descriptor for kretprobe_trampoline.=

> But, since this is a trampoline, I think that is good. So, for this
> patch:
> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks for the tips and the review. I fixed the issue you mentioned and=
 sent=20
a new patch with your Reviewed-by.

Also thanks for fixing the vmlinux-kallsyms issue in ppc64le. I didn=E2=
=80=99t=20
comment on the patches because I=E2=80=99m not very familiar with the c=
ode in=20
question.

--=20
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
