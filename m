Return-Path: <glikely@secretlab.ca>
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com
	[209.85.212.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C1AE9B6F7D
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Sep 2011 22:49:15 +1000 (EST)
Received: by vwl1 with SMTP id 1so468291vwl.15
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Sep 2011 05:49:11 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20110929113025.2b224cd3@wker>
References: <20110929113025.2b224cd3@wker>
Date: Thu, 29 Sep 2011 07:49:07 -0500
Message-ID: <CACxGe6s1K+rUbH7XinhHXqXvNzZ_QXwYfZHe8t1kzYj223ampg@mail.gmail.com>
Subject: Re: Please pull 'next' branch of 5xxx tree
From: Grant Likely <grant.likely@secretlab.ca>
To: Anatolij Gustschin <agust@denx.de>
Content-Type: multipart/alternative; boundary=20cf3078139e6cee8604ae13efa3
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--20cf3078139e6cee8604ae13efa3
Content-Type: text/plain; charset=ISO-8859-1

On Sep 29, 2011 4:31 AM, "Anatolij Gustschin" <agust@denx.de> wrote:
>
> Hi Ben,
>
> please pull another two mpc5xxx patches for next. These patches were
> queued in Grant's 'powerpc/next' branch a while ago, but a pull request
> have never been submitted for them. Thanks!
>
> Anatolij
>
> The following changes since commit
7680057cc4c7d9caada12767831bfd9738dd7b43:
>
>  powerpc: Don't try OPAL takeover on old 970 blades (2011-09-29 17:04:59
+1000)
>
> are available in the git repository at:
>  git://git.denx.de/linux-2.6-agust.git next
>
> Grant Likely (1):
>      powerpc/5200: add support for charon board

Hmmm, I didn't actually write this patch. It looks like the author credit
got screwed up at some point.

g.

>
> Heiko Schocher (1):
>      powerpc, tqm5200: update tqm5200_defconfig to fit for charon board.
>
>  arch/powerpc/boot/dts/charon.dts             |  236
++++++++++++++++++++++++++
>  arch/powerpc/configs/52xx/tqm5200_defconfig  |   20 ++-
>  arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
>  3 files changed, 249 insertions(+), 8 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/charon.dts
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--20cf3078139e6cee8604ae13efa3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p><br>
On Sep 29, 2011 4:31 AM, &quot;Anatolij Gustschin&quot; &lt;<a href=3D"mail=
to:agust@denx.de">agust@denx.de</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Ben,<br>
&gt;<br>
&gt; please pull another two mpc5xxx patches for next. These patches were<b=
r>
&gt; queued in Grant&#39;s &#39;powerpc/next&#39; branch a while ago, but a=
 pull request<br>
&gt; have never been submitted for them. Thanks!<br>
&gt;<br>
&gt; Anatolij<br>
&gt;<br>
&gt; The following changes since commit 7680057cc4c7d9caada12767831bfd9738d=
d7b43:<br>
&gt;<br>
&gt; =A0powerpc: Don&#39;t try OPAL takeover on old 970 blades (2011-09-29 =
17:04:59 +1000)<br>
&gt;<br>
&gt; are available in the git repository at:<br>
&gt; =A0git://<a href=3D"http://git.denx.de/linux-2.6-agust.git">git.denx.d=
e/linux-2.6-agust.git</a> next<br>
&gt;<br>
&gt; Grant Likely (1):<br>
&gt; =A0 =A0 =A0powerpc/5200: add support for charon board</p>
<p>Hmmm, I didn&#39;t actually write this patch. It looks like the author c=
redit got screwed up at some point.</p>
<p>g.</p>
<p>&gt;<br>
&gt; Heiko Schocher (1):<br>
&gt; =A0 =A0 =A0powerpc, tqm5200: update tqm5200_defconfig to fit for charo=
n board.<br>
&gt;<br>
&gt; =A0arch/powerpc/boot/dts/charon.dts =A0 =A0 =A0 =A0 =A0 =A0 | =A0236 +=
+++++++++++++++++++++++++<br>
&gt; =A0arch/powerpc/configs/52xx/tqm5200_defconfig =A0| =A0 20 ++-<br>
&gt; =A0arch/powerpc/platforms/52xx/mpc5200_simple.c | =A0 =A01 +<br>
&gt; =A03 files changed, 249 insertions(+), 8 deletions(-)<br>
&gt; =A0create mode 100644 arch/powerpc/boot/dts/charon.dts<br>
&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; <a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.oz=
labs.org</a><br>
&gt; <a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lis=
ts.ozlabs.org/listinfo/linuxppc-dev</a><br>
</p>

--20cf3078139e6cee8604ae13efa3--
