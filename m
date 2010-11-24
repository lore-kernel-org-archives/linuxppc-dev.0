Return-Path: <rsarmah@apm.com>
Received: from exprod5og113.obsmtp.com (exprod5og113.obsmtp.com [64.18.0.26])
	by ozlabs.org (Postfix) with SMTP id F21EAB6F10
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Nov 2010 15:55:08 +1100 (EST)
Received: by mail-wy0-f172.google.com with SMTP id 29so9317116wyb.17
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2010 20:55:06 -0800 (PST)
From: Rupjyoti Sarmah <rsarmah@apm.com>
References: <201011231256.oANCur3N016433@amcc.com>
	<201011231421.02377.sr@denx.de>
In-Reply-To: <201011231421.02377.sr@denx.de>
MIME-Version: 1.0
Date: Wed, 24 Nov 2010 10:25:03 +0530
Message-ID: <602c780cd2a81ee32f834a82814fe77f@mail.gmail.com>
Subject: RE: [PATCH v1] ppc44x:PHY fixup for USB on canyonlands board
To: Stefan Roese <sr@denx.de>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>
>> +#define BCSR_USB_EN	0x11
>This define is wrong here. Its not common for all 44x platforms but
Canyonlands specific.

So, do you suggest to move this macro to the canyonlands.c ? Or introduce
canyonlands.h ?

Regards,
Rup
