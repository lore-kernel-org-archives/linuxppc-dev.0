Return-Path: <mla@apm.com>
Received: from exprod5og104.obsmtp.com (exprod5og104.obsmtp.com [64.18.0.178])
 by ozlabs.org (Postfix) with SMTP id 1132AB701F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2012 14:27:43 +1000 (EST)
Received: by vbjk13 with SMTP id k13so4970285vbj.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2012 21:27:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1330505263-3718-1-git-send-email-mla@apm.com>
References: <1330505263-3718-1-git-send-email-mla@apm.com>
From: Mai La <mla@apm.com>
Date: Mon, 9 Apr 2012 11:27:21 +0700
Message-ID: <CAJ0-vugbTFnBF9aFKPt0yzP4+Uvpj0190RvuDhK1X5KWZYPDZg@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/44x: Add PCI MSI node for APM821xx SoC and
 Bluestone board in DTS
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Matt Porter <mporter@kernel.crashing.org>,
 Tirumala R Marri <tmarri@apm.com>, Grant Likely <grant.likely@secretlab.ca>,
 Michael Neuling <mikey@neuling.org>, Kumar Gala <galak@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=20cf30780f4a5104dd04bd376dfc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--20cf30780f4a5104dd04bd376dfc
Content-Type: text/plain; charset=ISO-8859-1

This patch is along with patch [1/2, v4] powerpc/44x: Fix PCI MSI support
for Maui APM821xx SoC and Bluestone board. Do you have any comment for this
patch?

Thank you!

On Wed, Feb 29, 2012 at 3:47 PM, Mai La <mla@apm.com> wrote:

>
> Signed-off-by: Mai La <mla@apm.com>
> ---
>  arch/powerpc/boot/dts/bluestone.dts |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/bluestone.dts
> b/arch/powerpc/boot/dts/bluestone.dts
> index 2a56a0d..8ea6325 100644
> --- a/arch/powerpc/boot/dts/bluestone.dts
> +++ b/arch/powerpc/boot/dts/bluestone.dts
> @@ -250,5 +250,29 @@
>                        };
>                };
>
> +               MSI: ppc4xx-msi@C10000000 {
> +                       compatible = "amcc,ppc4xx-msi", "ppc4xx-msi";
> +                       reg = < 0xC 0x10000000 0x100
> +                               0xC 0x10000000 0x100>;
> +                       sdr-base = <0x36C>;
> +                       msi-data = <0x00004440>;
> +                       msi-mask = <0x0000ffe0>;
> +                       interrupts =<0 1 2 3 4 5 6 7>;
> +                       interrupt-parent = <&MSI>;
> +                       #interrupt-cells = <1>;
> +                       #address-cells = <0>;
> +                       #size-cells = <0>;
> +                       msi-available-ranges = <0x0 0x100>;
> +                       interrupt-map = <
> +                               0 &UIC3 0x18 1
> +                               1 &UIC3 0x19 1
> +                               2 &UIC3 0x1A 1
> +                               3 &UIC3 0x1B 1
> +                               4 &UIC3 0x1C 1
> +                               5 &UIC3 0x1D 1
> +                               6 &UIC3 0x1E 1
> +                               7 &UIC3 0x1F 1
> +                       >;
> +               };
>        };
>  };
> --
> 1.7.3.4
>
>

--20cf30780f4a5104dd04bd376dfc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This patch is along with patch [1/2, v4] powerpc/44x: Fix PCI MSI support f=
or Maui APM821xx SoC and Bluestone board. Do you have any comment for this =
patch?<br><br>Thank you!<br><br><div class=3D"gmail_quote">On Wed, Feb 29, =
2012 at 3:47 PM, Mai La <span dir=3D"ltr">&lt;<a href=3D"mailto:mla@apm.com=
">mla@apm.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Signed-off-by: Mai La &lt;<a href=3D"mailto:mla@apm.com">mla@apm.com</a>&gt=
;<br>
---<br>
=A0arch/powerpc/boot/dts/bluestone.dts | =A0 24 ++++++++++++++++++++++++<br=
>
=A01 files changed, 24 insertions(+), 0 deletions(-)<br>
<br>
diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dts/bl=
uestone.dts<br>
index 2a56a0d..8ea6325 100644<br>
--- a/arch/powerpc/boot/dts/bluestone.dts<br>
+++ b/arch/powerpc/boot/dts/bluestone.dts<br>
@@ -250,5 +250,29 @@<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};<br>
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 MSI: ppc4xx-msi@C10000000 {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;amcc,ppc=
4xx-msi&quot;, &quot;ppc4xx-msi&quot;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &lt; 0xC 0x10000000 0=
x100<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xC 0x1000000=
0 0x100&gt;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdr-base =3D &lt;0x36C&gt;;<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msi-data =3D &lt;0x00004440&g=
t;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msi-mask =3D &lt;0x0000ffe0&g=
t;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D&lt;0 1 2 3 4 5=
 6 7&gt;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D &lt;&amp=
;MSI&gt;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D &lt;1&gt=
;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D &lt;0&gt;;=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D &lt;0&gt;;<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msi-available-ranges =3D &lt;=
0x0 0x100&gt;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-map =3D &lt;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 &amp;UIC3 0=
x18 1<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 &amp;UIC3 0=
x19 1<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2 &amp;UIC3 0=
x1A 1<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3 &amp;UIC3 0=
x1B 1<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 4 &amp;UIC3 0=
x1C 1<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 5 &amp;UIC3 0=
x1D 1<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 6 &amp;UIC3 0=
x1E 1<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 7 &amp;UIC3 0=
x1F 1<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
 =A0 =A0 =A0 =A0};<br>
=A0};<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.3.4<br>
<br>
</font></span></blockquote></div><br>

--20cf30780f4a5104dd04bd376dfc--
