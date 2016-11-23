Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNtHg167DzDvpJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 17:49:49 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAN6msH2114320
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 01:49:47 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26w3rpbxj8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 01:49:47 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 23 Nov 2016 16:49:44 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6C0D82CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 17:49:43 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAN6nhJF61472988
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 17:49:43 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAN6ng0b003756
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 17:49:43 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 fbarrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cxl: fix coccinelle warnings
In-reply-to: <20161122101327.14281-1-andrew.donnellan@au1.ibm.com>
References: <20161122101327.14281-1-andrew.donnellan@au1.ibm.com>
Date: Wed, 23 Nov 2016 17:49:41 +1100
Message-Id: <1479883732-sup-5050@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Most of these look fine

> -    return debugfs_create_file(name, mode, parent, (void __force *)value, &fops_io_x64);
> +    return debugfs_create_file_unsafe(name, mode, parent,
> +                      (void __force *)value, &fops_io_x64);

Just wondering what this one is about?

Cheers,
-Ian
