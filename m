Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2EAA367A2E
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 09:52:54 +1000 (EST)
Date: Wed, 21 Jun 2006 16:51:56 -0700
To: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [PATCH] Don't access HID registers if running on a Hypervisor.
Message-ID: <20060621235156.GA5414@pb15.lixom.net>
References: <E1FtBvP-00026H-TC@kmac.watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1FtBvP-00026H-TC@kmac.watson.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 21, 2006 at 07:15:55PM -0400, Jimi Xenidis wrote:
> 
> The following patch avoids accessing Hypervisor privilege HID
> registers when running on a Hypervisor (MSR[HV]=0).

I'm curious, why is this causing problems now? JS20 has been running
that code with a hypervisor since a long time back.


-Olof
