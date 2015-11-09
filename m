Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93DD51A018F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Nov 2015 17:46:28 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 60D1C1402C8
 for <linuxppc-dev@ozlabs.org>; Mon,  9 Nov 2015 17:46:28 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 9 Nov 2015 16:46:27 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 187752BB0052
 for <linuxppc-dev@ozlabs.org>; Mon,  9 Nov 2015 17:46:23 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA96kG5c25690300
 for <linuxppc-dev@ozlabs.org>; Mon, 9 Nov 2015 17:46:24 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA96jnGs021387
 for <linuxppc-dev@ozlabs.org>; Mon, 9 Nov 2015 17:45:50 +1100
Message-ID: <56404105.1010302@au1.ibm.com>
Date: Mon, 09 Nov 2015 17:45:25 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, Daniel Axtens <dja@axtens.net>,
 linuxppc-dev@ozlabs.org
CC: mikey@neuling.org, imunsie@au1.ibm.com
Subject: Re: [PATCH] cxl: use correct operator when writing pcie config space
 values
References: <1446603849-26796-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <87oaf8hwt2.fsf@gamma.ozlabs.ibm.com>
 <1446767022.25265.2.camel@ellerman.id.au>
In-Reply-To: <1446767022.25265.2.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/15 10:43, Michael Ellerman wrote:
> If it's unused *and* broken then we should just remove it.

Following some discussion with Ian and Vaibhav, we'd like to keep it at 
this stage - while there are no current AFUs which write to AFU config 
space, it would be reasonable for an AFU developer to assume that AFU 
config space is writable, and I am led to believe there is nothing in 
the publicly available documentation that would suggest otherwise.

Ian is working on obtaining a test AFU with support for this, at which 
point we will add it to our internal test suite.

As such I'd like to continue with the patch as is, I'm happy to drop the 
stable Cc though.


Andrew

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
