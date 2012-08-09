Return-Path: <adlai@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e5.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 512932C007F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 06:52:14 +1000 (EST)
Received: from /spool/local
 by e5.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <adlai@linux.vnet.ibm.com>;
 Thu, 9 Aug 2012 16:52:08 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 646756E806D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2012 16:51:10 -0400 (EDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q79Kp2ae21954782
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Aug 2012 16:51:03 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q79Kp0Dh008519
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Aug 2012 14:51:01 -0600
Message-ID: <1344545575.28791.4.camel@footlong>
Subject: Re: [PATCH 3/3] drivers/char/tpm: Add securityfs support for event log
From: Ashley Lai <adlai@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 09 Aug 2012 15:52:55 -0500
In-Reply-To: <1344369479.24990.9.camel@footlong>
References: <1344367748.24990.1.camel@footlong>
 <1344369479.24990.9.camel@footlong>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: rcj@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
 tpmdd-devel@lists.sourceforge.net, adlai@us.ibm.com, key@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kent,

Thanks for looking into it.  I'll fix in the next version.

Sorry if you got this message twice.  I have some issues with my mail
server.

Thanks,
--Ashley Lai
