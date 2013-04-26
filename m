Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C292D2C012A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 13:19:43 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Fri, 26 Apr 2013 08:44:39 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id BD75AE004A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 08:51:40 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3Q3JSgm66977922
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 08:49:28 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3Q3JXDL019867
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 03:19:34 GMT
Message-ID: <5179F241.2040301@linux.vnet.ibm.com>
Date: Fri, 26 Apr 2013 11:19:29 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: "attempt to move .org backwards" still show up
References: <5177965D.9090406@linux.vnet.ibm.com>
 <20130424083142.GB26834@concordia> <51779941.8080403@linux.vnet.ibm.com>
 <30651.1366799858@ale.ozlabs.ibm.com> <1366807638.5911.2.camel@localhost>
 <5178816D.3000309@asianux.com> <5178ABA2.4030109@linux.vnet.ibm.com>
 <20130425062539.GA421@iris.ozlabs.ibm.com>
In-Reply-To: <20130425062539.GA421@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: sfr@canb.auug.org.au, Michael Neuling <mikey@neuling.org>, matt@ozlabs.org,
 Chen Gang <gang.chen@asianux.com>, linux-kernel@vger.kernel.org,
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

于 2013/4/25 14:25, Paul Mackerras 写道:
> On Thu, Apr 25, 2013 at 12:05:54PM +0800, Mike Qiu wrote:
>> This has block my work now
>> So I hope you can take a look ASAP
>> Thanks
>> :)
>>
>> Mike
> As a quick fix, turn on CONFIG_KVM_BOOK3S_64_HV.  That will eliminate
> the immediate problem.
Thanks
got it, I will have a try.
> Paul.
>
