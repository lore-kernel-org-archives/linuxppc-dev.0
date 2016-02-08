Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 082D01A001D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 10:58:50 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A9916140C31
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Feb 2016 10:58:49 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 9 Feb 2016 09:58:47 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 87C652BB004D
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Feb 2016 10:58:41 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u18NwXJV60031214
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Feb 2016 10:58:41 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u18Nw8Wd022069
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Feb 2016 10:58:08 +1100
Subject: Re: powerpc/eeh: eeh_pci_enable(): fix checking of post-request state
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20160208113706.12246140B99@ozlabs.org>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56B92B74.8040108@au1.ibm.com>
Date: Tue, 9 Feb 2016 10:57:40 +1100
MIME-Version: 1.0
In-Reply-To: <20160208113706.12246140B99@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/02/16 22:37, Michael Ellerman wrote:
> Looks like I missed this?
>
> Should it still go in? Is it a fix? If so when did it break, and should it go
> to stable?

It is a fix - I'm a bit hazy on the details now but IIRC, Daniel Axtens 
and I encountered this when doing some cxl debugging, though I think we 
decided not to tag this for stable since it was a secondary issue to the 
primary bug we were looking for. It probably could go to stable though? 
(Daniel - thoughts?)

The line in question was last touched in 4d4f577e4b5e, but it looks like 
the behaviour wasn't right even before that.


Andrew

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
