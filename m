Return-Path: <stockhausen@collogia.de>
Received: from mailrelay.collogia.de (mailrelay.collogia.de [194.8.207.98])
 by lists.ozlabs.org (Postfix) with SMTP id 0BD5D1A0E00
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 00:41:50 +1100 (AEDT)
From: Markus Stockhausen <stockhausen@collogia.de>
To: Conor O'Gorman <i@conorogorman.net>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>
Subject: AW: [PATCH v1 0/3] SHA256 for PPC/SPE
Date: Fri, 30 Jan 2015 13:41:38 +0000
Message-ID: <12EF8D94C6F8734FB2FF37B9FBEDD1735F916EBD@EXCHANGE.collogia.de>
References: <5ad377b3-e491-4c35-8b89-de1dfd0749a6__44574.29146064$1422133918$gmane$org@EXCHANGE.collogia.de>,
 <54CB72E2.1030101@conorogorman.net>
In-Reply-To: <54CB72E2.1030101@conorogorman.net>
Content-Type: multipart/mixed;
 boundary="----=_NextPartTM-000-86235523-5ab9-4ace-b5c8-f7c5960a373e"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.

------=_NextPartTM-000-86235523-5ab9-4ace-b5c8-f7c5960a373e
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Von: Conor O'Gorman [i@conorogorman.net]=0A=
> Gesendet: Freitag, 30. Januar 2015 13:02=0A=
> An: Markus Stockhausen; linux-crypto@vger.kernel.org=0A=
> Cc: linuxppc-dev@lists.ozlabs.org=0A=
> Betreff: Re: [PATCH v1 0/3] SHA256 for PPC/SPE=0A=
> =0A=
> On 24/01/15 21:10, Markus Stockhausen wrote:=0A=
> > [PATCH v1 0/3] SHA256 for PPC/SPE=0A=
> >=0A=
> > The following patches add support for SIMD accelerated SHA256=0A=
> > calculation on PPC processors with SPE instruction set. The=0A=
> =0A=
> Nice boost.=0A=
> =0A=
> Many of the SoCs with e500 core have crypto hardware accelerators. How=0A=
> does this compare?=0A=
=0A=
May sound stupid but I failed to activate the device in my TP-Link WDR4900.=
=0A=
The whole story here: https://community.freescale.com/message/475816=0A=
=0A=
Markus=0A=
------=_NextPartTM-000-86235523-5ab9-4ace-b5c8-f7c5960a373e
Content-Type: text/plain;
	name="InterScan_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_Disclaimer.txt"

****************************************************************************
Diese E-Mail enthält vertrauliche und/oder rechtlich geschützte
Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail
irrtümlich erhalten haben, informieren Sie bitte sofort den Absender und
vernichten Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte
Weitergabe dieser Mail ist nicht gestattet.

Über das Internet versandte E-Mails können unter fremden Namen erstellt oder
manipuliert werden. Deshalb ist diese als E-Mail verschickte Nachricht keine
rechtsverbindliche Willenserklärung.

Collogia
Unternehmensberatung AG
Ubierring 11
D-50678 Köln

Vorstand:
Kadir Akin
Dr. Michael Höhnerbach

Vorsitzender des Aufsichtsrates:
Hans Kristian Langva

Registergericht: Amtsgericht Köln
Registernummer: HRB 52 497

This e-mail may contain confidential and/or privileged information. If you
are not the intended recipient (or have received this e-mail in error)
please notify the sender immediately and destroy this e-mail. Any
unauthorized copying, disclosure or distribution of the material in this
e-mail is strictly forbidden.

e-mails sent over the internet may have been written under a wrong name or
been manipulated. That is why this message sent as an e-mail is not a
legally binding declaration of intention.

Collogia
Unternehmensberatung AG
Ubierring 11
D-50678 Köln

executive board:
Kadir Akin
Dr. Michael Höhnerbach

President of the supervisory board:
Hans Kristian Langva

Registry office: district court Cologne
Register number: HRB 52 497

****************************************************************************

------=_NextPartTM-000-86235523-5ab9-4ace-b5c8-f7c5960a373e--
