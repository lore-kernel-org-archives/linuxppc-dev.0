Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C973D1A0915
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 10:02:21 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 14 Jan 2016 09:02:20 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E90223578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 10:02:13 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0DN254W34734238
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 10:02:13 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0DN1fwu026114
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 10:01:41 +1100
Subject: Re: [PATCH 2/5] misc: cxl: use kobj_to_dev()
To: Geliang Tang <geliangtang@163.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <286d4d5f873437fbc91c07369b4b57038c4667ce.1452698603.git.geliangtang@163.com>
 <6e8fbf9983f218aa373b870aa842f028a7bbc144.1452698603.git.geliangtang@163.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <5696D71D.6050402@au1.ibm.com>
Date: Thu, 14 Jan 2016 10:00:45 +1100
MIME-Version: 1.0
In-Reply-To: <6e8fbf9983f218aa373b870aa842f028a7bbc144.1452698603.git.geliangtang@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/01/16 02:30, Geliang Tang wrote:
> Use kobj_to_dev() instead of open-coding it.
>
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Good simplification.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
