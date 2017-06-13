Return-Path: <bsingharora@gmail.com>
Received: from mail-qt0-x236.google.com (mail-qt0-x236.google.com
 [IPv6:2607:f8b0:400d:c0d::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnQ5l58t9zDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 08:52:59 +1000 (AEST)
Received: by mail-qt0-x236.google.com with SMTP id w1so191024886qtg.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 15:52:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497336599-17894-1-git-send-email-kamalesh@linux.vnet.ibm.com>
References: <1497336599-17894-1-git-send-email-kamalesh@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 14 Jun 2017 08:52:55 +1000
Message-ID: <CAKTCnz=xeDFbyPwsdewq-5NK9cgQpBVCfCX_iL5f8u2-y7HwDw@mail.gmail.com>
Subject: Re: [PATCH] recordmcount.pl: Add ppc64le to list of supported
 architectures
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: multipart/alternative; boundary="001a11416730e2419f0551df4bef"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11416730e2419f0551df4bef
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 13, 2017 at 4:49 PM, Kamalesh Babulal <
kamalesh@linux.vnet.ibm.com> wrote:

> Module make on ppc64le, fails with:
>
> make -C /root/kernel/linux M=/root/.kpatch/tmp/patch
> kpatch-data-read-mostly.ko
> make[1]: Entering directory '/root/kernel/linux'
>   CC [M]  /root/.kpatch/tmp/patch/patch-hook.o
> Arch ppc64le is not supported with CONFIG_FTRACE_MCOUNT_RECORD at
> ./scripts/recordmcount.pl line 379.
>
> Fix it by adding 'ppc64le' to list of supported architectures
> in recordmcount.pl script.
>
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Balbir Singh <bsingharora@gmail.com>
> ---
>  scripts/recordmcount.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> index 1633c3e..683b8b5 100755
> --- a/scripts/recordmcount.pl
> +++ b/scripts/recordmcount.pl
> @@ -264,7 +264,7 @@ if ($arch eq "x86_64") {
>      $ld .= " -m shlelf_linux";
>      $objcopy .= " -O elf32-sh-linux";
>
> -} elsif ($arch eq "powerpc") {
> +} elsif ($arch eq "powerpc" || $arch eq "ppc64le") {
>

I don't get this, the arch should always be powerpc. Where did you get the
ppc64le
from? Am I missing anything?

Balbir Singh.

--001a11416730e2419f0551df4bef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Jun 13, 2017 at 4:49 PM, Kamalesh Babulal <span dir=3D"ltr">&lt=
;<a href=3D"mailto:kamalesh@linux.vnet.ibm.com" target=3D"_blank">kamalesh@=
linux.vnet.ibm.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Module make on ppc64le, fails with:<br>
<br>
make -C /root/kernel/linux M=3D/root/.kpatch/tmp/patch kpatch-data-read-mos=
tly.ko<br>
make[1]: Entering directory &#39;/root/kernel/linux&#39;<br>
=C2=A0 CC [M]=C2=A0 /root/.kpatch/tmp/patch/patch-<wbr>hook.o<br>
Arch ppc64le is not supported with CONFIG_FTRACE_MCOUNT_RECORD at ./scripts=
/<a href=3D"http://recordmcount.pl" rel=3D"noreferrer" target=3D"_blank">re=
cordmcount.pl</a> line 379.<br>
<br>
Fix it by adding &#39;ppc64le&#39; to list of supported architectures<br>
in <a href=3D"http://recordmcount.pl" rel=3D"noreferrer" target=3D"_blank">=
recordmcount.pl</a> script.<br>
<br>
Signed-off-by: Kamalesh Babulal &lt;<a href=3D"mailto:kamalesh@linux.vnet.i=
bm.com">kamalesh@linux.vnet.ibm.com</a>&gt;<br>
Cc: Michael Ellerman &lt;<a href=3D"mailto:mpe@ellerman.id.au">mpe@ellerman=
.id.au</a>&gt;<br>
Cc: Balbir Singh &lt;<a href=3D"mailto:bsingharora@gmail.com">bsingharora@g=
mail.com</a>&gt;<br>
---<br>
=C2=A0scripts/<a href=3D"http://recordmcount.pl" rel=3D"noreferrer" target=
=3D"_blank">recordmcount.pl</a> | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/scripts/<a href=3D"http://recordmcount.pl" rel=3D"noreferrer" =
target=3D"_blank">recordmcount.pl</a> b/scripts/<a href=3D"http://recordmco=
unt.pl" rel=3D"noreferrer" target=3D"_blank">recordmcount.pl</a><br>
index 1633c3e..683b8b5 100755<br>
--- a/scripts/<a href=3D"http://recordmcount.pl" rel=3D"noreferrer" target=
=3D"_blank">recordmcount.pl</a><br>
+++ b/scripts/<a href=3D"http://recordmcount.pl" rel=3D"noreferrer" target=
=3D"_blank">recordmcount.pl</a><br>
@@ -264,7 +264,7 @@ if ($arch eq &quot;x86_64&quot;) {<br>
=C2=A0 =C2=A0 =C2=A0$ld .=3D &quot; -m shlelf_linux&quot;;<br>
=C2=A0 =C2=A0 =C2=A0$objcopy .=3D &quot; -O elf32-sh-linux&quot;;<br>
<br>
-} elsif ($arch eq &quot;powerpc&quot;) {<br>
+} elsif ($arch eq &quot;powerpc&quot; || $arch eq &quot;ppc64le&quot;) {<b=
r></blockquote><div><br></div><div>I don&#39;t get this, the arch should al=
ways be powerpc. Where did you get the ppc64le</div><div>from? Am I missing=
 anything?</div><div>=C2=A0<br></div><div>Balbir Singh.</div></div><br></di=
v></div>

--001a11416730e2419f0551df4bef--
