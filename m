Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C6C5E1A0D60
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 10:18:10 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9F73B1409C2
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2015 10:18:10 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 6 Nov 2015 09:18:09 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E4CF42CE8052
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2015 10:18:06 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA5NHiof35651784
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Nov 2015 10:17:52 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA5NHYwM017794
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Nov 2015 10:17:34 +1100
Message-ID: <563BE375.2000309@au1.ibm.com>
Date: Fri, 06 Nov 2015 10:17:09 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
CC: mikey@neuling.org, imunsie@au1.ibm.com
Subject: Re: [PATCH] cxl: use correct operator when writing pcie config space
 values
References: <1446603849-26796-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <87oaf8hwt2.fsf@gamma.ozlabs.ibm.com>
In-Reply-To: <87oaf8hwt2.fsf@gamma.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/15 10:05, Daniel Axtens wrote:
> Given that there are no current users of this function, does this need
> to go to stable? Does it actually fix a real (as opposed to theoretical)
> bug?

I tagged it for stable on mpe's request - I'm not fussed either way.


Andrew

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
