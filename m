Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E3E381A308A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 16:19:48 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 1 Dec 2015 15:19:47 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 312D22CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 16:19:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB15JahA52887692
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 16:19:44 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB15JCtJ031175
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 16:19:12 +1100
Message-ID: <565D2DB8.80205@au1.ibm.com>
Date: Tue, 01 Dec 2015 16:18:48 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/3] selftests/powerpc: Transactional Memory
References: <1448946504-11653-1-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1448946504-11653-1-git-send-email-rashmicy@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/12/15 16:08, Rashmica Gupta wrote:
> This is reliant on the following patch series:
> - selftests/powerpc by Michael Ellerman
> - selftests/powerpc by Michael Neuling
> - powerpc/tm by Michael Neuling

Could you provide the full titles of the patch series? (Links to 
patchwork.ozlabs.org are good too.)


Andrew

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
