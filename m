Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402s1T3q8KzF0nG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 03:51:41 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2GGn9vV103432
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 12:51:38 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2grg0vmxkb-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 12:51:38 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Fri, 16 Mar 2018 12:51:37 -0400
Subject: Re: [PATCH 2/3] rfi-flush: Make it possible to call setup_rfi_flush()
 again
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org
References: <1518644021-17037-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1518644021-17037-3-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20180215081358.2f37cda4@naga.suse.cz>
 <b87d6261-c48d-6eab-e328-6988f628c949@linux.vnet.ibm.com>
 <87lgforngp.fsf@concordia.ellerman.id.au>
 <20180220180621.11265945@kitsune.suse.cz>
 <2bb5a110-3ea4-af5c-81fb-cf5350587dff@linux.vnet.ibm.com>
 <876069flhq.fsf@concordia.ellerman.id.au>
 <20180306135522.040707de@kitsune.suse.cz>
 <f11fdded-9d5e-d06f-b75e-d0a802b2005d@linux.vnet.ibm.com>
 <876060gq5s.fsf@concordia.ellerman.id.au>
 <c7cadceb-1957-046e-8934-592baccca5b7@linux.vnet.ibm.com>
 <20180313185916.3e4a0ea6@kitsune.suse.cz>
 <db75ecdd-32da-d429-8ea6-3bd1453bd89e@linux.vnet.ibm.com>
 <20180313193652.069ed57b@kitsune.suse.cz>
 <ff878619-a2c4-2dd2-8d39-ed0a535a9b8d@linux.vnet.ibm.com>
 <87lgesgl2y.fsf@concordia.ellerman.id.au>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 13:51:32 -0300
MIME-Version: 1.0
In-Reply-To: <87lgesgl2y.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <00189945-c147-4c8c-fa4a-515bcfdae6cb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael,

On 03/16/2018 11:18 AM, Michael Ellerman wrote:
>> I still think the correct, informative messages are a good way to go:)
> Yeah I agree.
> 
> We probably want to do both, print what's available at boot, and print
> what's actually patched when the patching happens.

Nice.  Not sure you had a chance to review yet, but 'PATCH v3 4/5' does
exactly that :- )

I think its implementation of the latter part looks a bit strange, but I
couldn't figure an elegant way to fit that in (either that one or string
array indexed by flush-type possible values or a long if-else chain).

I'd be happy with suggestions if it's preferred in some other way.

cheers,
Mauricio
