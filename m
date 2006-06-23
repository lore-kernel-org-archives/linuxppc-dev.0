Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 850E367A5F
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 10:29:19 +1000 (EST)
In-Reply-To: <20060622225609.GA4877@w-mikek2.ibm.com>
References: <20060622225609.GA4877@w-mikek2.ibm.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1B83F621-4C9A-4B82-9133-15CAE30CAC7A@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Date: Fri, 23 Jun 2006 02:28:41 +0200
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>, Arnd Bergmann <arnd@arndb.de>,
	Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Statistic files are moved to debugfs, and remain split out by CPU.

Having done some if this myself long ago, I really like to see these
per-cpu statistics.  "Not useful" in real life, but for most testcases
they're invaluable.  It would be useful to also add a "total" column
as well, of course, but it can also be done in userland.


Segher
