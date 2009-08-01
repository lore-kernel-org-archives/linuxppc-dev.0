Return-Path: <linasvepstas@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 271E3B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  2 Aug 2009 08:43:21 +1000 (EST)
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com
	[209.85.211.171]) by ozlabs.org (Postfix) with ESMTP id 79159DDD1B
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Aug 2009 08:43:20 +1000 (EST)
Received: by ywh1 with SMTP id 1so3148738ywh.9
	for <linuxppc-dev@ozlabs.org>; Sat, 01 Aug 2009 15:43:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A721FB1.4040903@us.ibm.com>
References: <4A721FB1.4040903@us.ibm.com>
Date: Sat, 1 Aug 2009 17:43:18 -0500
Message-ID: <3ae3aa420908011543t1260b971g41ee80fa78c4f471@mail.gmail.com>
Subject: Re: [PATCH 1/3] Support for PCI Express reset type
From: Linas Vepstas <linasvepstas@gmail.com>
To: Mike Mason <mmlnx@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Richard Lary <rlary@us.ibm.com>,
	Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/7/30 Mike Mason <mmlnx@us.ibm.com>:
> This is the first of three patches that implement a bit field that PCI
> Express device drivers can use to indicate they need a fundamental reset
> during error recovery.
>
> By default, the EEH framework on powerpc does what's known as a "hot rese=
t"
> during recovery of a PCI Express device. =C2=A0We've found a case where t=
he
> device needs a "fundamental reset" to recover properly. =C2=A0The current=
 PCI
> error recovery and EEH frameworks do not support this distinction.
>
> The attached patch (courtesy of Richard Lary) adds a bit field to pci_dev
> that indicates whether the device requires a fundamental reset during
> recovery.
>
> These patches supersede the previously submitted patch that implemented a
> fundamental reset bit field.
> Please review and let me know of any concerns.
>
> Signed-off-by: Mike Mason <mmlnx@us.ibm.com>
> Signed-off-by: Richard Lary <rlary@us.ibm.com>


Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>
