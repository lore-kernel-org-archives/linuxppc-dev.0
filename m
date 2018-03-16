Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402rpb5zSbzDqjt
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 03:42:15 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2GGfDFx076217
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 12:42:13 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2grdtbak0y-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 12:42:12 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Fri, 16 Mar 2018 12:42:11 -0400
Subject: Re: [PATCH v3 1/5] rfi-flush: Move the logic to avoid a redo into the
 debugfs code
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
References: <1521067243-19520-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1521067243-19520-2-git-send-email-mauricfo@linux.vnet.ibm.com>
 <4ae7af3f-219e-33dc-d7fa-49141d268222@linux.vnet.ibm.com>
 <20180316095200.78f31a50@naga.suse.cz>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 13:42:07 -0300
MIME-Version: 1.0
In-Reply-To: <20180316095200.78f31a50@naga.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <bd359480-5b04-91d5-2a9e-9129c6772c41@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Murilo and Michal,

On 03/16/2018 05:52 AM, Michal Suchánek wrote:
>> Do we need to take into account if no_rfi_flush == true?

> I think it makes sense you are able to override that using debugfs.
> 
> It's interface used for diagnostics and testing.
> 
> If this was in sysfs it would be a different story.

Yes, I agree. The debugfs is way to override the cmdline option.

Thanks for looking carefully at this :)

cheers,
Mauricio
