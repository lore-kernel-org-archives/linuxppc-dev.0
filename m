Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 68683DDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 08:00:57 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3RM0q94025896
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 15:00:53 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n3RM0ox0013936
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 17:00:51 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9C783.A05105AB"
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
Date: Tue, 28 Apr 2009 05:59:41 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB12089136ED5@zch01exm21.fsl.freescale.net>
References: <20090424183517.GB23140@ovro.caltech.edu><D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "Tabi Timur-B04825" <timur@freescale.com>
Cc: Ira Snyder <iws@ovro.caltech.edu>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Dan Williams <dan.j.williams@intel.com>,
	Zhang Wei <wei.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9C783.A05105AB
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

>> You are assuming the PCI memory space is prefetchable( no side =
effect)
>> for DMA.
>> Is it possible that DMA is from non-prefetchable memory space?

> This should be a safe assumption for this driver.  Remember, this
> driver just does offload memcpy, from one region to another.  So the
> PCI memory that you are reading from should be just a buffer of data,
> and there should be side-effect of reading it.

How about one FIFO buffer?


------_=_NextPart_001_01C9C783.A05105AB
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dgb2312">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>Re: [PATCH] fsldma: use PCI Read Multiple command</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>&gt;&gt; You are assuming the PCI memory space is =
prefetchable( no side effect)<BR>
&gt;&gt; for DMA.<BR>
&gt;&gt; Is it possible that DMA is from non-prefetchable memory =
space?<BR>
<BR>
&gt; This should be a safe assumption for this driver.&nbsp; Remember, =
this<BR>
&gt; driver just does offload memcpy, from one region to another.&nbsp; =
So the<BR>
&gt; PCI memory that you are reading from should be just a buffer of =
data,<BR>
&gt; and there should be side-effect of reading it.<BR>
<BR>
How about one FIFO buffer?<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C9C783.A05105AB--
