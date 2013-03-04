Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 351392C02F9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2013 14:15:04 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Mon, 4 Mar 2013 13:08:40 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DC4923578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2013 14:14:56 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2432DRj56229892
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Mar 2013 14:02:14 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r243EtGG012152
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Mar 2013 14:14:56 +1100
Message-ID: <513411AD.5010408@linux.vnet.ibm.com>
Date: Mon, 04 Mar 2013 11:14:53 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 0/3] Enable multiple MSI feature in pSeries
References: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <1362107325.2712.2.camel@localhost> <20130301035417.GA17236@concordia>
In-Reply-To: <20130301035417.GA17236@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

于 2013/3/1 11:54, Michael Ellerman 写道:
> On Fri, Mar 01, 2013 at 11:08:45AM +0800, Mike wrote:
>> Hi all
>>
>> Any comments? or any questions about my patchset?
> You were going to get some performance numbers that show a definite
> benefit for using more than one MSI.
Yes, but my patch just enable the kernel to support this feature, whether
to use it depens on the device driver.

And this feature has been merged to the kernel for X86 for a long time.
See commit: 5ca72c4f7c412c2002363218901eba5516c476b1
51906e779f2b13b38f8153774c4c7163d412ffd9

Actually, I'm trying to do the test. but it is difficult to do that test,
because it mostly depends on how the device driver to use this feature,
while the ipr driver patch was wrote by another person. also no any reply
from her.


> cheers
>
