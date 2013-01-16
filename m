Return-Path: <R.Patil@mei-india.com>
Received: from antispam.messung.com (outbond.messung.com [210.212.173.45])
 by ozlabs.org (Postfix) with ESMTP id 986B32C007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2013 00:31:02 +1100 (EST)
In-Reply-To: 
Subject: SD Card over SPI, not working for MPC8313 
From: R.Patil@mei-india.com
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <OF36C99B74.048D73FE-ON65257AF5.004A3F3C-65257AF5.004A3F44@LocalDomain>
Date: Wed, 16 Jan 2013 19:00:58 +0530
Content-Type: multipart/alternative;
 boundary="=_alternative 004A3F3E65257AF5_="
References: 
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=_alternative 004A3F3E65257AF5_=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=ISO-8859-1
MIME-Version: 1.0

 Hello,

We are working on board based on Freescale MPC8313ERDB. We have ported linu=
x 3.0.46 kernel on it. We have to use SD card over SPI. We are trying to us=
e 'mmc=5Fspi' driver for the same. We are able to detect SD card insertion =
by the interrupt (gpio interrupt is used to detect card insertion). But we =
are not able to initialise the card. Is the 'mmc=5Fspi' support for MPC8313=
ERDB broken?=20

If no, what could be the reason we are getting timeout error by function 'm=
mc=5Fspi=5Fresponse=5Fget()'?&nbsp;=20

If anybody could just give a hint to solve or debug the problem.&nbsp;=20

Thanks and Regards,
Rahul Patil
Email Disclaimer:
  ---------------------------

This e-mail and any files transmitted with it are for the sole use of the i=
ntended recipient(s) and may contain confidential and  privileged informati=
on. Computer viruses can be transmitted via email.The recipient should chec=
k this email and any  attachments for the presence of viruses. The company =
accepts no liability for any damage caused by any virus transmitted by this=
 email.

--=_alternative 004A3F3E65257AF5_=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<font face=3D"Default Sans Serif,Verdana,Arial,Helvetica,sans-serif" size=
=3D"2"> <div><font face=3D"Courier New,Courier,monospace" size=3D"3">Hello,=
<br><br>We are working on board based on Freescale MPC8313ERDB. We have por=
ted linux 3.0.46 kernel on it. We have to use SD card over SPI. We are tryi=
ng to use 'mmc=5Fspi' driver for the same. We are able to detect SD card in=
sertion by the interrupt (gpio interrupt is used to detect card insertion).=
 But we are not able to initialise the card. Is the 'mmc=5Fspi' support for=
 MPC8313ERDB broken? <br><br>If no, what could be the reason we are getting=
 timeout error by function 'mmc=5Fspi=5Fresponse=5Fget()'?&nbsp; <br><br>If=
 anybody could just give a hint to solve or debug the problem.&nbsp; <br><b=
r>Thanks and Regards,<br>Rahul Patil<br><br></font></div></font>Email Discl=
aimer:<BR>
  ---------------------------<BR>
<BR>
This e-mail and any files transmitted with it are for the sole use of the i=
ntended recipient(s) and may contain confidential and  privileged informati=
on. Computer viruses can be transmitted via email.The recipient should chec=
k this email and any  attachments for the presence of viruses. The company =
accepts no liability for any damage caused by any virus transmitted by this=
 email.<BR>

--=_alternative 004A3F3E65257AF5_=--
