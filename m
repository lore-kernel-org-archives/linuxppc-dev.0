Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7DE43679E1
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Aug 2006 00:00:10 +1000 (EST)
Message-ID: <44D352DE.9060007@cambridgebroadband.com>
Date: Fri, 04 Aug 2006 14:59:58 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: GSM909@gmx.de
Subject: Re: invalidate_dcache_range Kernel 2.6.14
References: <20060804130938.78980@gmx.net>
In-Reply-To: <20060804130938.78980@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

GSM909@gmx.de wrote:
> I have an old driver that need the funktion invalidate_dcache_range but when I compile the driver : Unknown symbol invalidate_dcache_range.
> 
> Whats the name of this funktion now ???
> 

The same.  You just need to add EXPORT_SYMBOL(invalidate_dcache_range) to
ppc_ksys.c for your module to see it.


> Regards
> Ted

Alex
