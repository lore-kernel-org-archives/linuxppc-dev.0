Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E102C2C00B7
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Aug 2013 14:02:51 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 7 Aug 2013 09:24:17 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6AED9E004F
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Aug 2013 09:33:00 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7743xNi35979324
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Aug 2013 09:33:59 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7742iZi022833
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Aug 2013 09:32:44 +0530
Message-ID: <5201C6BA.6090504@linux.vnet.ibm.com>
Date: Wed, 07 Aug 2013 09:32:02 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Convert out of line __arch_hweight to inline
References: <1375788627-22281-1-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1375788627-22281-1-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
>  obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
>  			   memcpy_64.o usercopy_64.o mem_64.o string.o \
> -			   checksum_wrappers_64.o hweight_64.o \
> +			   checksum_wrappers_64.o \
>  			   copyuser_power7.o string_64.o copypage_power7.o \
>  			   memcpy_power7.o
>  obj-$(CONFIG_PPC_EMULATE_SSTEP)	+= sstep.o ldstfp.o
> 

As you have moved all the code from hweight_64.S file and removed it from the
compilation list in the Makefile, you need to delete the file from the directory as well.
