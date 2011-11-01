Return-Path: <openspace.wang@gmail.com>
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com
 [209.85.210.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 377B8B6F7B
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2011 17:25:45 +1100 (EST)
Received: by iakc1 with SMTP id c1so578199iak.15
 for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2011 23:25:43 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 1 Nov 2011 14:25:43 +0800
Message-ID: <CAPxxNQnhXaKJ5ve-=0qwChuuvDj_027RM2pSD43DEf6BZbaHDA@mail.gmail.com>
Subject: What does rmo/tce stand for in powerpc?
From: Ryan Wang <openspace.wang@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=bcaec529a051cc5a4504b0a66c6c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--bcaec529a051cc5a4504b0a66c6c
Content-Type: text/plain; charset=ISO-8859-1

Hi,

In kernel source comments, I saw the words:
''

alloc_top is set to the top of RMO, eventually shrink down if the
<http://lxr.linux.no/linux+*/arch/powerpc/kernel/prom_init.c#L972>TCEs
overlap

''

I wonder what does RMO mean, and TCE?

thanks,

--bcaec529a051cc5a4504b0a66c6c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>In kernel source comments, I saw the words:<br>&#39;&#39;<br><pr=
e class=3D"done" id=3D"33/70/d71ef2461494331766b72ceea619564f00c3_3/0"><spa=
n class=3D"comment">alloc_top is set to the top of RMO, eventually shrink d=
own if the</span> <a href=3D"http://lxr.linux.no/linux+*/arch/powerpc/kerne=
l/prom_init.c#L972" id=3D"L972" class=3D"line" name=3D"L972"></a><span clas=
s=3D"comment">TCEs overlap</span>
</pre>&#39;&#39;<br><br>I wonder what does RMO mean, and TCE?<br><br>thanks=
,<br><br><br>

--bcaec529a051cc5a4504b0a66c6c--
