Return-Path: <bgerst@didntduck.org>
Received: from quark.didntduck.org (quark.didntduck.org [69.55.226.66])
	by ozlabs.org (Postfix) with ESMTP id 40C7A2BF0E
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 14:12:48 +1100 (EST)
Message-ID: <41DB4E99.3060200@didntduck.org>
Date: Tue, 04 Jan 2005 21:19:05 -0500
From: Brian Gerst <bgerst@didntduck.org>
MIME-Version: 1.0
To: James Nelson <james4765@cwazy.co.uk>
References: <20050104214048.21749.85722.89116@localhost.localdomain>
In-Reply-To: <20050104214048.21749.85722.89116@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] ppc: remove cli()/sti() from arch/ppc/*
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

James Nelson wrote:
> This series of patches is to remove the last cli()/sti() function calls in arch/ppc.
> 
> These are the only instances in active code that grep could find.

Are you sure none of these need real spinlocks instead of just disabling 
interrupts?

--
				Brian Gerst
