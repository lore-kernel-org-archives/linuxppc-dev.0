Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7602DDDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Nov 2008 11:44:22 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mA50hUXC016489
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Nov 2008 17:43:30 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mA50iG2m119370
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Nov 2008 17:44:17 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mA50iFPV002906
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Nov 2008 17:44:16 -0700
Date: Tue, 4 Nov 2008 19:44:11 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Mitch Crane <mcrane@fusionio.com>
Subject: Re: booting 32 bit kernel on G5
Message-ID: <20081104194411.0ad8ceeb@zod.rchland.ibm.com>
In-Reply-To: <385918C0-E800-4DA0-92F3-2755BCEB7434@fusionio.com>
References: <385918C0-E800-4DA0-92F3-2755BCEB7434@fusionio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 4 Nov 2008 11:32:10 -0700
Mitch Crane <mcrane@fusionio.com> wrote:

> Hi all,
> 
> First off, I apologize for not searching the archives, I'm afraid the  
> link is broken: http://lists.linuxppc.org/rules.html
> 
> My AMCC Katmai is on order.  In the meantime I'd like to try building  
> and running my driver on my Mac G5 PPC64, running in 32 bit mode.  I  
> have a recent YDL distro installed, and can rebuild the kernel,  
> switching off 64 bit in the kernel build config.  However, when I try  
> to boot the 32 bit kernel it hangs in the open firmware "release keys  
> to continue" screen.  Can someone please lend a hand here?  Has anyone  
> accomplished a 32 bit boot on a Mac G5 with a 2.6 kernel?

That support was taken out quite a while ago.  It's no longer possible
from what I remember.

josh
