Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id CD703DDE0D
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 01:05:43 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l1EE5eAW029702
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 07:05:41 -0700 (MST)
Received: from Artemis.local (mvp-10-214-73-46.am.freescale.net [10.214.73.46])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1EE5ew0002364
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 08:05:40 -0600 (CST)
Message-ID: <45D31734.7030808@freescale.com>
Date: Wed, 14 Feb 2007 08:05:40 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
References: <11713852392294-git-send-email-timur@freescale.com>
	<20070214003119.GF11491@localhost.localdomain>
	<45D29BBA.7090401@freescale.com>
	<20070214052440.GB12609@localhost.localdomain>
In-Reply-To: <20070214052440.GB12609@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> The interrupt-controller property in /chosen just points to the
> system's top-level interrupt controller to make it easier for the
> kernel to find in the tree.  I think most platforms don't actually
> need or use it at present, but booting-without-of does recommend it.
> 
> As such it's a property of the board, not something which will change
> from boot to boot.  It would therefore be rather strange for the
> bootloader to poke this property.

That's all the more reason to delete the 'chosen' section, isn't it? 
Sicne it's wrong, deleting the entire section will just make the problem 
go away.  Or am I missing something?
