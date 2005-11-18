Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8B8F568797
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2005 18:42:47 +1100 (EST)
Date: Fri, 18 Nov 2005 08:42:37 +0100
From: Olaf Hering <olh@suse.de>
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Message-ID: <20051118074237.GA14865@suse.de>
References: <20051117210902.GB31775@suse.de>
	<437D0A21.4090803@smiths-aerospace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <437D0A21.4090803@smiths-aerospace.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc boot: replace string labels with numbers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Thu, Nov 17, Jerry Van Baren wrote:

> While I'm being dumb, I gotta ask, how big is zImage and why does 117 
> bytes make a difference?

Because we can.

> My 2c: if you are going to use inscrutable labels (1,2,3,4), please put 
> comments in.  At least the previous labels gave hints as to what was 
> happening.

The code should be obvious.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
