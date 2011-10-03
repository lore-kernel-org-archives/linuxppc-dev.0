Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out01.wipro.com (wipro-blr-out01.wipro.com
	[203.91.198.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 162F4B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Oct 2011 23:38:09 +1100 (EST)
From: <smitha.vanga@wipro.com>
To: <scottwood@freescale.com>
Subject: Request_irq fails for IRQ2 
Date: Mon, 3 Oct 2011 12:31:34 +0000
Message-ID: <40631E9A2581F14BA60888C87A76A1FE0145B6@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <4E57FD3D.6090809@freescale.com>
Content-Type: multipart/alternative;
	boundary="_000_40631E9A2581F14BA60888C87A76A1FE0145B6HYDMKDMBX4wiproco_"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_40631E9A2581F14BA60888C87A76A1FE0145B6HYDMKDMBX4wiproco_
Content-Type: text/plain; charset="us-ascii"
content-transfer-encoding: quoted-printable


Hi Scott,

 I try to request an IRQ (IRQ2 and IRQ3 which are ineterrupt no 20 and 21 in=
 mpc8247)in my driver . The
Call fails in setup_irq in Manage.c at /kernel/irq.

Setup _irq returns -ENOSYS

if (desc->irq_data.chip =3D=3D &no_irq_chip)
                 return -ENOSYS;

I just want to know why it fails. Below is the call to request irq in my dri=
ver.


#define CPLD1_INTERRUPT  20
if (request_irq(CPLD1_INTERRUPT,cpld_irq_handler, 0, GPIO_CHAR_PATH, NULL))
   {
      printk(KERN_ERR "gpio_init: Could not grab IRQ line for CPLD\n");
          goto err1;
   }

Regards,
Smitha



Please do not print this email unless it is absolutely necessary. =0A=
=0A=
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. =0A=
=0A=
WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email. =0A=
=0A=
www.wipro.com

--_000_40631E9A2581F14BA60888C87A76A1FE0145B6HYDMKDMBX4wiproco_
Content-Type: text/html; charset="us-ascii"
content-transfer-encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial" size=3D"2"><span style=3D"font-size:10pt;">
<div>&nbsp;</div>
<div>Hi Scott,</div>
<div>&nbsp;</div>
<div> I try to request an IRQ (IRQ2 and IRQ3 which are ineterrupt no 20 and=
 21 in mpc8247)in my driver . The</div>
<div>Call fails in setup_irq in Manage.c at /kernel/irq. </div>
<div>&nbsp;</div>
<div>Setup _irq returns -ENOSYS</div>
<div>&nbsp;</div>
<div><font color=3D"red">if (desc-&gt;irq_data.chip =3D=3D &amp;no_irq_chip)=
</font></div>
<div><font color=3D"red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOSYS;</font></div>
<div><font color=3D"red">&nbsp;</font></div>
<div>I just want to know why it fails. Below is the call to request irq in m=
y driver. </div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>#define CPLD1_INTERRUPT&nbsp; 20</div>
<div>if <b>(request_irq(CPLD1_INTERRUPT,cpld_irq_handler, 0, GPIO_CHAR_PATH,=
 NULL</b>))</div>
<div>&nbsp;&nbsp; {</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_ERR &quot;gpio_init: Could n=
ot grab IRQ line for CPLD\n&quot;);</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; goto err1;</div>
<div>&nbsp;&nbsp; }</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Smitha</div>
<div><font color=3D"red">&nbsp;</font></div>
<div><font color=3D"red">&nbsp;</font></div>
</span></font>
<P><strong><span style=3D'font-size:10.0pt;font-family:=0A=
"Palatino Linotype","serif";color:green'> Please do not print this email unl=
ess it is absolutely necessary. </span></strong><span style=3D'font-family:"=
Arial","sans-serif"'><o:p></o:p></span></p>=0A=
=0A=
=0A=
<p> The information contained in this electronic message and any attachments=
 to this message are intended for the exclusive use of the addressee(s) and=
 may contain proprietary, confidential or privileged information. If you are=
 not the intended recipient, you should not disseminate, distribute or copy=
 this e-mail. Please notify the sender immediately and destroy all copies of=
 this message and any attachments. </p>=0A=
=0A=
<p>WARNING: Computer viruses can be transmitted via email. The recipient sho=
uld check this email and any attachments for the presence of viruses. The co=
mpany accepts no liability for any damage caused by any virus transmitted by=
 this email. </p>=0A=
<p>=0A=
www.wipro.com=0A=
</p>
</body>
</html>

--_000_40631E9A2581F14BA60888C87A76A1FE0145B6HYDMKDMBX4wiproco_--
