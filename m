Return-Path: <a.llano@usyscom.com>
Received: from correo.ziv.es (eu31-237.clientes.euskaltel.es [212.55.31.237])
	by ozlabs.org (Postfix) with ESMTP id C3CF467B46
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 04:32:23 +1100 (EST)
Subject: Stability of MPC5200 FEC
From: "Asier Llano Palacios" <a.llano@ziv.es>
To: <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain;
	charset="ISO-8859-15"
Date: Fri, 10 Feb 2006 18:20:10 +0100
Message-ID: <1139592010.14894.22.camel@localhost.localdomain>
MIME-Version: 1.0
Cc: Sylvain Munaut <tnt@246tNt.com>, John Rigby <jrigby@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We are working with MPC5200 cpu.=20
We've been using it since early 2.6 kernel versions.
We're currently quite stabilished with the version of the kernel Sylvain
had before the Platform Device rework. But the problem is that we are
experiencing that the FEC stops working after a long uptime.

So, do you think that the current git version is more stable than the
one we are using? Do you think that there is anything that could stop us
upgrading to the latest version?

The problem is that we have a custom board, with some custom devices, so
it is not so easy to upgrade. We need to know that a new version, is
more stable than the previous one, before we upgrade. As soon as we
upgrade, we can help if we find any problem.

Thank you,
Asier Llano

--=20
Asier Llano Palacios
ZIV I+D Smart Energy Networks
Dpto. Ingenier=EDa de Desarrollo.

ZIV, Aplicaciones y Tecnolog=EDa.
Parque Tecnol=F3gico, 210
48170 ZAMUDIO (Bizkaia)

E-mail: a.llano@ziv.es
Tlfno: (+34)944037400=20
=20
----------------------------------------- PLEASE NOTE =
-------------------------------------------
This message, along with any attachments, may be confidential or legally =
privileged.=20
It is intended only for the named person(s), who is/are the only =
authorized recipients.
If this message has reached you in error, kindly destroy it without =
review and notify the sender immediately.
Thank you for your help.
=B5SysCom uses virus scanning software but excludes any liability for =
viruses contained in any attachment.
=20
------------------------------------ ROGAMOS LEA ESTE TEXTO =
-------------------------------
Este mensaje y sus anexos pueden contener informaci=F3n confidencial y/o =
con derecho legal.=20
Est=E1 dirigido =FAnicamente a la/s persona/s o entidad/es rese=F1adas =
como =FAnico destinatario autorizado.
Si este mensaje le hubiera llegado por error, por favor elim=EDnelo sin =
revisarlo ni reenviarlo y notif=EDquelo inmediatamente al remitente. =
Gracias por su colaboraci=F3n. =20
=B5SysCom utiliza software antivirus, pero no se hace responsable de los =
virus contenidos en los ficheros anexos.
