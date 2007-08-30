Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9C441DDDFD
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 07:28:21 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7ULSHoJ016106
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 17:28:17 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7ULSHHp546302
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 17:28:17 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7ULSHt1014768
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 17:28:17 -0400
Date: Thu, 30 Aug 2007 16:28:16 -0500
To: Joachim Fenkes <FENKES@de.ibm.com>
Subject: Re: [PATCH 2.6.23] ibmebus: Prevent bus_id collisions
Message-ID: <20070830212816.GA4263@austin.ibm.com>
References: <46D5BBFA.5060200@austin.ibm.com>
	<OF9D1ED44F.896DCCC5-ONC1257347.0044D256-C1257347.004CFB07@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF9D1ED44F.896DCCC5-ONC1257347.0044D256-C1257347.004CFB07@de.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Thomas Q Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	Paul Mackerras <pmac@au1.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Nathan Lynch <ntl@pobox.com>, Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2007 at 04:00:56PM +0200, Joachim Fenkes wrote:
> 
> Plus, I rather like using 
> the full_name since it also contains a descriptive name as opposed to 
> being just nondescript numbers, helping the layman (ie user) to make sense 
> out of a dev_id.

Yes, well, but no. The location code is useful as a geographical
location: slots and devices are physically labelled with stickers 
so you can tell which is which.  Handy when you have to unplug stuff. 
By contrast, the device-tree full_name is mostly just gobldy-gook, 
with some crazy phb numbering in there that, after four years of 
staring at them, I still can't reliably do anything useful with.  
Location codes are nice. 

--linas
