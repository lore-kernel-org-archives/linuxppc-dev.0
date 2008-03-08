Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from QMTA04.emeryville.ca.mail.comcast.net
	(qmta04.emeryville.ca.mail.comcast.net [76.96.30.40])
	by ozlabs.org (Postfix) with ESMTP id 5DC4DDDF48
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Mar 2008 00:25:31 +1100 (EST)
Message-ID: <47D29407.3020804@gmail.com>
Date: Sat, 08 Mar 2008 08:26:31 -0500
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH v2] Make 83xx perfmon support selectable
References: <1204934343-5235-1-git-send-email-afleming@freescale.com>
In-Reply-To: <1204934343-5235-1-git-send-email-afleming@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andy Fleming wrote:
> Not all e300 cores support the performance monitors, and the ones
> that don't will be confused by the mf/mtpmr instructions.  This
> allows the support to be optional, so the 8349 can turn it off
> while the 8379 can turn it on.  Sadly, those aren't config options,
> so it will be left to the defconfigs and the users to make that
> determination.
> 
> Signed-off-by: Andy Fleming <afleming@freescale.com>

Thanks, Andy!

FWIIW,
Acked-by: Gerald Van Baren <vanbaren@cideas.com>
