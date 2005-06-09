Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw2.extranet.tce.com (dmzraw2.extranet.tce.com
	[157.254.234.138]) by ozlabs.org (Postfix) with ESMTP id A650467B25
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 19:56:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 9 Jun 2005 11:35:24 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0D77@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: <scarayol@assystembrime.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: =?iso-8859-1?q?RE=3A_R=E9f=2E_=3A_Re=3A_Read_in_/dev/port_with_S?=
	=?iso-8859-1?q?egmentation__Fault?=
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sophie CARAYOL wrote:
>Another question, if i use mmap to map physical addresses of I/O =
registers,
>could i dereference the pointer on virtual adresse to access data or =
should
>i use read/write on the file descriptor ?

Yes, you can dereference the pointer.
Don't you remember my past mail?

>From the Denx's FAQ (TFQ hits the list monthly) for accessing memory =
bus:

http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acces=
singPeripheralsFromUserSpace
or shorter: http://tinyurl.com/6c7th

See linux/drivers/char/mem.c to check if mmap support is ok on your =
arch.

Kenavo
--=20
St=E9phane
