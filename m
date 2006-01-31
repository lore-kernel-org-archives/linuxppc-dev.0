Return-Path: <mustafa.cayir@bte.mam.gov.tr>
Received: from itri.bte.mam.gov.tr (bte.mam.gov.tr [193.140.75.15])
	by ozlabs.org (Postfix) with ESMTP id 7E7E468A21
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Feb 2006 00:28:20 +1100 (EST)
Message-ID: <000e01c62669$f7c3be60$9e01120a@bilisim.local>
From: =?iso-8859-9?Q?Mustafa_=C7ay=FDr?= <mustafa.cayir@bte.mam.gov.tr>
To: <linuxppc-embedded@ozlabs.org>
Subject: Entry Point Address
Date: Tue, 31 Jan 2006 15:26:39 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-9"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
=20
does entry point adress defined uboot image header correspond to adress =
of which function in linux kernel ?

file :/common/cmd_bootm.c=20
function : do_bootm_linux
     kernel =3D (void (*)(bd_t *, ulong, ulong, ulong, =
ulong))hdr->ih_ep;

Thanks,
