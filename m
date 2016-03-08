Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3687B1A011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 18:44:38 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F248414012C
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 18:44:37 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 8 Mar 2016 17:44:33 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 75CA82BB006A
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 18:43:53 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u287hjVS11010234
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2016 18:43:53 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u287hK77031924
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2016 18:43:21 +1100
Subject: Re: powerpc/eeh: eeh_pci_enable(): fix checking of post-request state
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20160208113706.12246140B99@ozlabs.org>
 <56B92B74.8040108@au1.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56DE8280.6020302@au1.ibm.com>
Date: Tue, 8 Mar 2016 18:42:56 +1100
MIME-Version: 1.0
In-Reply-To: <56B92B74.8040108@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/02/16 10:57, Andrew Donnellan wrote:
> It is a fix - I'm a bit hazy on the details now but IIRC, Daniel Axtens
> and I encountered this when doing some cxl debugging, though I think we
> decided not to tag this for stable since it was a secondary issue to the
> primary bug we were looking for. It probably could go to stable though?
> (Daniel - thoughts?)
>
> The line in question was last touched in 4d4f577e4b5e, but it looks like
> the behaviour wasn't right even before that.

Ping :)

I think this patch should still go in, I don't really care whether it 
goes to stable or not.

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
