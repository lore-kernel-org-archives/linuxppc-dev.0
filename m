Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out01.wipro.com (wipro-blr-out01.wipro.com
	[203.91.198.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 576C9B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Oct 2011 17:15:48 +1100 (EST)
From: <smitha.vanga@wipro.com>
To: <scottwood@freescale.com>
Subject: RE: Request_irq fails for IRQ2
Date: Tue, 4 Oct 2011 06:15:26 +0000
Message-ID: <40631E9A2581F14BA60888C87A76A1FE014671@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <4E89EFB2.6060704@freescale.com>
Content-Type: multipart/alternative;
	boundary="_000_40631E9A2581F14BA60888C87A76A1FE014671HYDMKDMBX4wiproco_"
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

--_000_40631E9A2581F14BA60888C87A76A1FE014671HYDMKDMBX4wiproco_
Content-Type: text/plain; charset="us-ascii"
content-transfer-encoding: quoted-printable

Hi Scott,

Thank you. But I am not very clear where exactly I need to call the irq_set_=
default_host().
And also for the second fix I did not understand or to make cpm2_pic_host no=
n-static (in which case you should pass that).
in th previous mail what exactlyy you mean.

Thanks & Regards,

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

--_000_40631E9A2581F14BA60888C87A76A1FE014671HYDMKDMBX4wiproco_
Content-Type: text/html; charset="us-ascii"
content-transfer-encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<title></title>
<meta content=3D"MSHTML 6.00.2900.3698" name=3D"GENERATOR">
</head>
<body>
<!-- Converted from text/plain format -->
<p><font size=3D"2">Hi Scott,<br>
<br>
Thank you. But I am not very clear where exactly I need to call the irq_set_=
default_host().<br>
And also for the second fix I did not understand <font color=3D"#0000ff">or=
 to make cpm2_pic_host non-static (in which case you should pass that).<br>
</font><font color=3D"#000000">in th previous mail what exactlyy you mean.</=
font></font></p>
<p><font size=3D"2"><font color=3D"#000000">Thanks &amp; Regards,</font></fo=
nt></p>
<p><font size=3D"2"><font color=3D"#000000">Smitha<br>
<br>
</font></p>
</font>
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

--_000_40631E9A2581F14BA60888C87A76A1FE014671HYDMKDMBX4wiproco_--
