Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0603C2C009B
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Dec 2013 20:56:18 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 16 Dec 2013 19:56:13 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B955E2BB002D
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Dec 2013 20:56:06 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBG9trQ62621752
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Dec 2013 20:55:54 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBG9u5kP031129
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Dec 2013 20:56:06 +1100
Message-ID: <52AECE33.3050101@linux.vnet.ibm.com>
Date: Mon, 16 Dec 2013 15:26:03 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] This patch adds support to read error logs from OPAL
 and export them
References: <20131216051720.30807.40785.stgit@mars.in.ibm.com>
In-Reply-To: <20131216051720.30807.40785.stgit@mars.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/16/2013 10:47 AM, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> to userspace through sysfs interface /sys/firmware/opa/opal-elog.
> 
> This patch buffers 128 error log records until it is consumed by userspace
> tool. This patch provides an sysfs interface '/sys/firmware/opa/opal-elog-ack'
> to user to receive an acknowledgement of successful log consumption.
> 
> This is what user space tool would do:
> - Read error log from /sys/firmware/opa/opal-elog.
> - Save it to the disk.
> - Send an acknowledgement on successful consumption by writing error log
>   id to /sys/firmware/opa/opal-elog-ack.
> 
> Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>

Please ignore this patch. I messed up the subject line, I dunno how.. My
bad. I will resend this patch with correct subject.

Thanks,
-Mahesh.
