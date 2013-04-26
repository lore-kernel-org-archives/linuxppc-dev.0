Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8E0902C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 11:58:31 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Fri, 26 Apr 2013 11:50:39 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7E85A2CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 11:58:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3Q1ib8O17760320
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 11:44:37 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3Q1wMID005486
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 11:58:23 +1000
Message-ID: <5179DF37.8020407@linux.vnet.ibm.com>
Date: Fri, 26 Apr 2013 09:58:15 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: "attempt to move .org backwards" still show up
References: <5177965D.9090406@linux.vnet.ibm.com>
 <20130424083142.GB26834@concordia> <51779941.8080403@linux.vnet.ibm.com>
 <30651.1366799858@ale.ozlabs.ibm.com> <1366807638.5911.2.camel@localhost>
 <5178816D.3000309@asianux.com> <5178ABA2.4030109@linux.vnet.ibm.com>
 <20130425062539.GA421@iris.ozlabs.ibm.com> <51791076.9040405@asianux.com>
In-Reply-To: <51791076.9040405@asianux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: sfr@canb.auug.org.au, Michael Neuling <mikey@neuling.org>, matt@ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
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

于 2013/4/25 19:16, Chen Gang 写道:
> On 2013年04月25日 14:25, Paul Mackerras wrote:
>> On Thu, Apr 25, 2013 at 12:05:54PM +0800, Mike Qiu wrote:
>>>> This has block my work now
>>>> So I hope you can take a look ASAP
>>>> Thanks
>>>> :)
>>>>
>>>> Mike
>> As a quick fix, turn on CONFIG_KVM_BOOK3S_64_HV.  That will eliminate
>> the immediate problem.
> Yes, just as my original reply to Mike to bypass it, but get no reply, I
> guess he has to face the CONFIG_KVM_BOOK3S_64_PR.
>
> Now, I am just fixing it, when I finish one patch, please help check.
Actually, I have compile pass by your patch, but I see Micheal Neuling's 
reply,
I just stop to do that, and wait for you new patch :)

Now I will use your V2 patch to build

Thanks

Mike
> Thanks.
>
