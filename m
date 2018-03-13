Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4012z26Fw4zF0Tn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 05:13:18 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2DIBc6s096958
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 14:13:16 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gpj5cm4xa-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 14:13:15 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Tue, 13 Mar 2018 12:13:15 -0600
Subject: Re: [PATCH 2/3] rfi-flush: Make it possible to call setup_rfi_flush()
 again
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org
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
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Tue, 13 Mar 2018 15:13:11 -0300
MIME-Version: 1.0
In-Reply-To: <20180313185916.3e4a0ea6@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <db75ecdd-32da-d429-8ea6-3bd1453bd89e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/13/2018 02:59 PM, Michal Suchánek wrote:
> Maybe it would make more sense to move the messages to the function
> that actually patches in the instructions?

That helps, but if the instructions are not patched (e.g., no_rfi_flush)
then there is no information about what the system actually supports,
which is useful for diagnostics/debugging (and patch verification! :-) )

cheers,
mauricio
