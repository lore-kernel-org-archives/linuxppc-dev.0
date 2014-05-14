Return-Path: <michael.neuling@gmail.com>
Received: from mail-pb0-x229.google.com (mail-pb0-x229.google.com
 [IPv6:2607:f8b0:400e:c01::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A1C6C140082
 for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2014 21:18:03 +1000 (EST)
Received: by mail-pb0-f41.google.com with SMTP id uo5so1210166pbc.28
 for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2014 04:18:00 -0700 (PDT)
MIME-Version: 1.0
Sender: michael.neuling@gmail.com
In-Reply-To: <53735044.5030008@redhat.com>
References: <1399276469-13541-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1399276469-13541-3-git-send-email-khandual@linux.vnet.ibm.com>
 <537252C0.6090005@redhat.com> <53730326.6000400@linux.vnet.ibm.com>
 <53735044.5030008@redhat.com>
Date: Wed, 14 May 2014 21:18:00 +1000
Message-ID: <CAEjGV6y8-zOtOgxcg-6viNQh-RuzQCAy8JvJ+m-dc7XQnAkJmA@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] powerpc, ptrace: Enable support for transactional
 memory register sets
From: Michael Neuling <mikey@neuling.org>
To: Pedro Alves <palves@redhat.com>
Content-Type: multipart/alternative; boundary=047d7bacb78a549e7704f95a558d
Cc: avagin@openvz.org, oleg@redhat.com, linux-kernel@vger.kernel.org,
 michael@ellerman.id.au, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7bacb78a549e7704f95a558d
Content-Type: text/plain; charset=UTF-8

> s390 actually screwed that, though it got away because
> there's a bit in HWCAP to signal transactions support.  See:
>
>  https://sourceware.org/ml/gdb-patches/2013-11/msg00080.html
>
> Are you adding something to HWCAP too?

Yes but it's in HWCAP2

Mikey

--047d7bacb78a549e7704f95a558d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
&gt; s390 actually screwed that, though it got away because<br>
&gt; there&#39;s a bit in HWCAP to signal transactions support. =C2=A0See:<=
br>
&gt;<br>
&gt; =C2=A0<a href=3D"https://sourceware.org/ml/gdb-patches/2013-11/msg0008=
0.html">https://sourceware.org/ml/gdb-patches/2013-11/msg00080.html</a><br>
&gt;<br>
&gt; Are you adding something to HWCAP too?<br>
 <br>
Yes but it&#39;s in HWCAP2</p>
<p dir=3D"ltr">Mikey</p>

--047d7bacb78a549e7704f95a558d--
