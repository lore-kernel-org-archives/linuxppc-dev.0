Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qjxxy4dPSzDq9n
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 14:32:54 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 11 Apr 2016 14:32:53 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9141B2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 14:32:44 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3B4Wakk4063512
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 14:32:44 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3B4WBjL025852
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 14:32:12 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com
Subject: Re: cxl: fix setting of _PAGE_USER bit when handling page faults
In-Reply-To: <1460348865.3444.0.camel@ellerman.id.au>
References: <3qWf364wYxz9sDG@ozlabs.org> <8737rau3b7.fsf@linux.vnet.ibm.com>
 <570B23CD.3090203@au1.ibm.com> <1460348865.3444.0.camel@ellerman.id.au>
Date: Mon, 11 Apr 2016 10:01:44 +0530
Message-ID: <878u0kahqn.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Mon, 2016-04-11 at 14:10 +1000, Andrew Donnellan wrote:
>> On 29/03/16 00:42, Aneesh Kumar K.V wrote:
>> > I noticed this when doing radix support and have a variant posted at
>> > 
>> > https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-March/141036.html
>> 
>> I'm happy for this to be fixed in your radix series.
>
> I'm not :)
>
> This needs a stand-alone fix that we can backport.
>

It is done as an independent patch 

http://mid.gmane.org/1460182444-2468-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com

-aneesh
