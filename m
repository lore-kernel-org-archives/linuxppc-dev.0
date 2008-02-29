Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id C92CFDDDEC
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 12:40:07 +1100 (EST)
Date: Thu, 28 Feb 2008 19:39:57 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [PATCH 0/3] hotplug memory remove updates
Message-ID: <20080229013957.GQ16241@localdomain>
References: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Badari Pulavarty wrote:
> Hi Paul,
> 
> Here are the hotplug memory remove updates for 2.6.25-rc2-mm1.

How have these been tested?  Have you initiated a memory remove
operation from the HMC?  That's the only way to catch some bugs...
