Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CD544679E1
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Mar 2006 19:08:22 +1100 (EST)
Date: Wed, 8 Mar 2006 09:08:16 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: please pull powerpc-merge.git
Message-ID: <20060308080816.GA16866@suse.de>
References: <17422.16982.705624.256207@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17422.16982.705624.256207@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, torvalds@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, Mar 08, Paul Mackeras wrote:

>       powerpc: incorrect rmo_top handling in prom_init

I would leave this one out. It gives the false impression that ibook1
works ok, while later it will likely eat your filesystem. Its not a
regression in that sense because 2.6.15 was also broken and noone
complained.
