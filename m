Return-Path: <clg@fr.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 76F171A0CF3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 03:54:09 +1100 (AEDT)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 16 Feb 2015 16:54:04 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id B6D73219007F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 16:53:56 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1GGrfRp10944782
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 16:53:41 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1GGreEC031813
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 09:53:40 -0700
Message-ID: <54E2207D.3040605@fr.ibm.com>
Date: Mon, 16 Feb 2015 17:53:17 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/5 v2] powerpc/boot/fdt: Add little-endian support to
 libfdt wrappers
References: <1423630544.752438.317337864668.2.gpush@pablo>
In-Reply-To: <1423630544.752438.317337864668.2.gpush@pablo>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/11/2015 05:55 AM, Jeremy Kerr wrote:
> For epapr-style boot, we may be little-endian. This change implements
> the proper conversion for fdt*_to_cpu and cpu_to_fdt*. We also need the
> full cpu_to_* and *_to_cpu macros for this.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


I did not work on the little endian epapr wrapper :/

To test the patchset, I used the 'le' branch of git://github.com/jk-ozlabs/linux 
and successfully booted a tuleta and an open-power system using the latest 
skiboot and a LE zImage.epapr. Looks good to me. 

You might want to add CONFIG_IPMI_WATCHDOG to openpower_defconfig 

Thanks.

C.
