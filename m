Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2387B6884B
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2005 09:28:45 +1100 (EST)
Date: Thu, 1 Dec 2005 23:28:39 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051201222839.GA7092@suse.de>
References: <20051201204632.GA3764@suse.de>
	<17295.30816.292109.714074@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17295.30816.292109.714074@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: hide CONFIG_ALTIVEC on iSeries
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Dec 02, Paul Mackeras wrote:

> Does it cause any actual problem to have CONFIG_ALTIVEC offered on
> legacy iSeries?

Its just an unneeded question when running oldconfig on an older .config
for iseries. I cant test if it causes any trouble.
CPU_FREQ is similar, but I dont see an easy way to hide it.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
