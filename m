Return-Path: <olh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A402267A77
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 22:48:15 +1000 (EST)
Date: Fri, 26 May 2006 14:48:09 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] force 64bit mode in system_reset_fwnmi for broken POWER4
	firmware
Message-ID: <20060526124809.GA22090@suse.de>
References: <20060522164111.GA14462@suse.de> <20060523130717.GA22364@suse.de>
	<17526.59069.781220.922878@cargo.ozlabs.ibm.com>
	<20060526123321.GA21866@suse.de>
	<17526.63315.759402.679928@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17526.63315.759402.679928@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, May 26, Paul Mackeras wrote:

> Olaf Hering writes:
> 
> > According to some firmware guys, the OS is supposed to force 64bit mode
> > on reset.
> 
> Who?  I'll get a platform architect to drop on them from a great
> height. :)

LTC22581 for the full story.
