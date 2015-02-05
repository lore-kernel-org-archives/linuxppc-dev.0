Return-Path: <dan.carpenter@oracle.com>
Received: from userp1050.oracle.com (userp1050.oracle.com [156.151.31.82])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C384D1A0E61
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 19:41:33 +1100 (AEDT)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 t158fV0s032661
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 08:41:31 GMT
Date: Thu, 5 Feb 2015 11:41:14 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Subject: Re: [RFC 00/10] Freescale DPAA B/QMan drivers
Message-ID: <20150205084114.GC5336@mwanda>
References: <1423061322-16059-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423061322-16059-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: devel@driverdev.osuosl.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Normally, for staging drivers we just require the TODO and a maintainer
and we merge things as-is.  There isn't really much review of the code.

regards,
dan carpenter
