Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.229])
	by ozlabs.org (Postfix) with ESMTP id CF5BADE45E
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 17:13:12 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so775739rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 00:13:11 -0700 (PDT)
Message-ID: <319b0ac50808210013p677ebb91vf3b30748138c6d4c@mail.gmail.com>
Date: Thu, 21 Aug 2008 09:13:11 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [machdep_calls] IRQ
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_20853_10773112.1219302791502"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_20853_10773112.1219302791502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

What are the constraints in order to implement a irq_init function ?
I think it has to set the mask. Does it enable IRQ ?

What is the aim or get_irq ? Does it retun an information about the mask,
the states, or... ?

Thanks
S=E9bastien Chr=E9tien

------=_Part_20853_10773112.1219302791502
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,<br>
<br>
What are the constraints in order to implement a irq_init function ? <br>
I think it has to set the mask. Does it enable IRQ ?<br>
<br>
What is the aim or get_irq ? Does it retun an information about the mask, t=
he states, or... ?<br>
<br>
Thanks<br>
S=E9bastien Chr=E9tien<br>

------=_Part_20853_10773112.1219302791502--
