Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4DD9D2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 18:35:32 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 18:27:32 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2A3EA2BB0053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 18:35:20 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O8ZDQj1573228
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 18:35:13 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O8ZIbS025750
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 18:35:19 +1000
Message-ID: <51779941.8080403@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 16:35:13 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: "attempt to move .org backwards" still show up
References: <5177965D.9090406@linux.vnet.ibm.com>
 <20130424083142.GB26834@concordia>
In-Reply-To: <20130424083142.GB26834@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: sfr@canb.auug.org.au, mikey@neuling.org, matt@ozlabs.org,
 gang.chen@asianux.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

于 2013/4/24 16:31, Michael Ellerman 写道:
> On Wed, Apr 24, 2013 at 04:22:53PM +0800, Mike Qiu wrote:
>> Hi all
>>
>> I get an error message when I compile the source code in Power7 platform
>> use the newest upstream kernel.
> Hi Mike,
>
> It depends on what your .config is. What defconfig are you building?
I just copy the config file from /boot/config.* to .config and use make 
menuconfig
change nothing by manually, then save.
> cheers
>
