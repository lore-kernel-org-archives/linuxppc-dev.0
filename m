Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C871367C18
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 19:04:46 +1000 (EST)
Date: Fri, 9 Jun 2006 11:04:41 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] force 64bit mode in system_reset_fwnmi for broken POWER4
	firmware
Message-ID: <20060609090441.GA22410@suse.de>
References: <20060522164111.GA14462@suse.de> <20060523130717.GA22364@suse.de>
	<17545.11572.518355.586057@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17545.11572.518355.586057@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Jun 09, Paul Mackeras wrote:

> Olaf Hering writes:
> 
> > The reason is that system_reset_fwnmi is called in 32bit mode. Forcing
> > 64bit mode fixes the corrupt NIP for me. JS20 and p690 are affected,
> > seems to work on p550 and JS21.
> 
> What was the LTC bugzilla number for this again?

LTC22581, the last comments confirm that firmware leaves the cpu in
32bit mode.
