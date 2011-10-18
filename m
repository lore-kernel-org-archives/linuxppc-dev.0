Return-Path: <vneethv@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
 [209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0DB0AB6F87
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 20:11:15 +1100 (EST)
Received: by bkbzs8 with SMTP id zs8so544881bkb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 02:11:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE016391@HYD-MKD-MBX4.wipro.com>
References: <B8D6CA50DACE9E4AAADE9A4D56FBAAE623BEB3@039-SN1MPN1-005.039d.mgd.msft.net>
 <40631E9A2581F14BA60888C87A76A1FE016391@HYD-MKD-MBX4.wipro.com>
From: Vineeth <vneethv@gmail.com>
Date: Tue, 18 Oct 2011 14:40:50 +0530
Message-ID: <CAFbQSaBWXSWvDJavCzBf=gXj6g39BkB+xERyGyLXHqkLOuojkA@mail.gmail.com>
Subject: Re: IRQ2 and IRQ 3
To: smitha.vanga@wipro.com, linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0015174a0faeb667f104af8f1a7a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0015174a0faeb667f104af8f1a7a
Content-Type: text/plain; charset=ISO-8859-1

interrupts <IRQ_NO,POLARITY>


 i2c@3000 {
            #address-cells = <1>;
            #size-cells = <0>;
            cell-index = <0>;
            compatible = "fsl-i2c";
            reg = <0x3000 0x100>;
            interrupts = <43 2>;
            interrupt-parent = <&mpic>;
            dfsrr;
        };




On Tue, Oct 18, 2011 at 2:35 PM, <smitha.vanga@wipro.com> wrote:

> Yes , there is a vector numbe defined in the specifications .
>
> IRQ2 - 20
> IRQ3 - 21
>
> But I don't know how to specify them in the .dts file .
>
> Regards,
> Smitha
> Please do not print this email unless it is absolutely necessary.
>
> The information contained in this electronic message and any attachments to
> this message are intended for the exclusive use of the addressee(s) and may
> contain proprietary, confidential or privileged information. If you are not
> the intended recipient, you should not disseminate, distribute or copy this
> e-mail. Please notify the sender immediately and destroy all copies of this
> message and any attachments.
>
> WARNING: Computer viruses can be transmitted via email. The recipient
> should check this email and any attachments for the presence of viruses. The
> company accepts no liability for any damage caused by any virus transmitted
> by this email.
>
> www.wipro.com
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

--0015174a0faeb667f104af8f1a7a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

interrupts &lt;IRQ_NO,POLARITY&gt;<br><br><br>=A0i2c@3000 {<br>=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 #address-cells =3D &lt;1&gt;;<br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 #size-cells =3D &lt;0&gt;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 cell-index =3D &lt;0&gt;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compa=
tible =3D &quot;fsl-i2c&quot;;<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D &lt;0x3000 0x100&gt;;<br>=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupts =3D &lt;43 2&gt;;<br>=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 interrupt-parent =3D &lt;&amp;mpic&gt;;<br>=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 dfsrr;<br>=A0=A0=A0=A0=A0=A0=A0 };<br><br><br><br><br=
><div class=3D"gmail_quote">On Tue, Oct 18, 2011 at 2:35 PM,  <span dir=3D"=
ltr">&lt;<a href=3D"mailto:smitha.vanga@wipro.com">smitha.vanga@wipro.com</=
a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">Yes , there is a vector numbe defined in th=
e specifications .<br>
<br>
IRQ2 - 20<br>
IRQ3 - 21<br>
<br>
But I don&#39;t know how to specify them in the .dts file .<br>
<br>
Regards,<br>
Smitha<br>
Please do not print this email unless it is absolutely necessary.<br>
<br>
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and ma=
y contain proprietary, confidential or privileged information. If you are n=
ot the intended recipient, you should not disseminate, distribute or copy t=
his e-mail. Please notify the sender immediately and destroy all copies of =
this message and any attachments.<br>


<br>
WARNING: Computer viruses can be transmitted via email. The recipient shoul=
d check this email and any attachments for the presence of viruses. The com=
pany accepts no liability for any damage caused by any virus transmitted by=
 this email.<br>


<br>
<a href=3D"http://www.wipro.com" target=3D"_blank">www.wipro.com</a><br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
</blockquote></div><br>

--0015174a0faeb667f104af8f1a7a--
