Return-Path: <tmarri@apm.com>
Received: from exprod5og106.obsmtp.com (exprod5og106.obsmtp.com [64.18.0.182])
	by ozlabs.org (Postfix) with SMTP id AB61AB70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Dec 2010 12:35:34 +1100 (EST)
Received: by qyk12 with SMTP id 12so12384302qyk.19
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 03 Dec 2010 17:35:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20101129183535.GA5603@zod.rchland.ibm.com>
References: <1289852106-17577-1-git-send-email-tmarri@apm.com>
	<20101129183535.GA5603@zod.rchland.ibm.com>
Date: Fri, 3 Dec 2010 17:35:31 -0800
Message-ID: <AANLkTikMfLCgPi2GKUMd6PNSmVhxiJTLPDyVBcuMjOt1@mail.gmail.com>
Subject: Re: [PATCH v2] PPC4xx: Adding PCI(E) MSI support
From: Tirumala Marri <tmarri@apm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary=00163628399aa3791004968bab0b
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00163628399aa3791004968bab0b
Content-Type: text/plain; charset=ISO-8859-1

>+      msi_mask = of_get_property(dev->dev.of_node, "msi-mask", NULL);
> >+      if (!msi_mask) {
> >+              err = -1;
> >+              goto error_out;
> >+      }
>
> This will return non zero value to probe function which would call
ppc4xx_msi_remove() function. In the ppc4xx_msi_remove() function  there is
iounamp() fuction.
Thanks,
Marri

--00163628399aa3791004968bab0b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><div cl=
ass=3D"im">
&gt;+ =A0 =A0 =A0msi_mask =3D of_get_property(dev-&gt;dev.of_node, &quot;ms=
i-mask&quot;, NULL);<br>
&gt;+ =A0 =A0 =A0if (!msi_mask) {<br>
&gt;+ =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -1;<br>
&gt;+ =A0 =A0 =A0 =A0 =A0 =A0 =A0goto error_out;<br>
&gt;+ =A0 =A0 =A0}<br>
<br></div></blockquote><div>This will return non zero value to probe functi=
on which would call ppc4xx_msi_remove() function. In the ppc4xx_msi_remove(=
) function =A0there is iounamp() fuction.</div><div>Thanks,</div><div>Marri=
</div>
</div><br>

--00163628399aa3791004968bab0b--
