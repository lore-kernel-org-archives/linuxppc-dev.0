Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C90E2C00BF
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Jul 2013 16:19:46 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 18 Jul 2013 16:16:47 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E2CCC2BB0051
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Jul 2013 16:19:39 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6I64MjK51642578
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Jul 2013 16:04:23 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6I6Jc2x011773
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Jul 2013 16:19:38 +1000
Message-ID: <51E788D4.4000809@linux.vnet.ibm.com>
Date: Thu, 18 Jul 2013 11:49:00 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: Add second POWER8 PVR entry
References: <16137.1374111111@ale.ozlabs.ibm.com>
In-Reply-To: <16137.1374111111@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: miltonm@realtime.net, Linux PPC dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/18/2013 07:01 AM, Michael Neuling wrote:
> POWER8 comes with two different PVRs.  This patch enables the additional
> PVR in the cputable.
> 
> The existing entry (PVR=0x4b) is renamed to POWER8E and the new entry
> (PVR=0x4d) is given POWER8.

Hey Mikey,

Is there any feature or architectural difference between these two different
PVR based P8 chips ?

Regards
Anshuman
