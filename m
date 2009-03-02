Return-Path: <kodiakuppercut@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 1427EDDEEF
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 09:09:34 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1389737ywb.39
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Mar 2009 14:09:33 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 2 Mar 2009 15:09:33 -0700
Message-ID: <bc81dc640903021409s49032382t6700cbfb416922e3@mail.gmail.com>
Subject: DTS format for direct SGMII TSEC link?
From: Aaron Pace <kodiakuppercut@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,
I am working with a Freescale 8572 board which uses direct SGMII
connections (no real PHY) for three of the four TSECs.  I have been
trying to figure out the appropriate DTS elements to set this up, but
haven't yet managed to figure it out.  Everything works great in
u-boot, so I know that the connections & hardware are functional.
I've tried setting up dummy physical phys, using only the tbi-phy, and
using the 'fixed-link' property, none of which have achieved the
desired result.
I realize I'm taking the lazy way out by not digging into the gianfar
code, but I was hoping that this problem had already been seen and
addressed and could be handled with the right text in the DTS file.

Thanks,
Aaron Pace
