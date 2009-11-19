Return-Path: <mchan@broadcom.com>
Received: from MMS3.broadcom.com (mms3.broadcom.com [216.31.210.19])
	by ozlabs.org (Postfix) with ESMTP id 899A6B6F14
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 10:07:36 +1100 (EST)
Subject: Re: tg3: link is permanently down after ifdown and ifup
From: "Michael Chan" <mchan@broadcom.com>
To: "Felix Radensky" <felix@embedded-sol.com>,
	mcarlson@broadcom.com
In-Reply-To: <4B056D85.5010904@embedded-sol.com>
References: <4B056158.5060104@embedded-sol.com>
	<4B056D85.5010904@embedded-sol.com>
Date: Thu, 19 Nov 2009 14:50:53 -0800
Message-ID: <1258671053.14964.20.camel@nseg_linux_HP1.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Thu, 2009-11-19 at 08:08 -0800, Felix Radensky wrote:
> Hi,
> 
> The problem goes away if I remove the call to
> 
> tg3_set_power_state(tp, PCI_D3hot);
> 
> from tg3_close().

Added Matt to CC.  He is on vacation and may not be able to look into
this right away.  Thanks.
