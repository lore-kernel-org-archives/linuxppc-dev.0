Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EAA7A2C00F1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 12:06:07 +1000 (EST)
Message-ID: <5179E0D3.8020507@asianux.com>
Date: Fri, 26 Apr 2013 10:05:07 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: "attempt to move .org backwards" still show up
References: <5177965D.9090406@linux.vnet.ibm.com>
 <20130424083142.GB26834@concordia> <51779941.8080403@linux.vnet.ibm.com>
 <30651.1366799858@ale.ozlabs.ibm.com> <1366807638.5911.2.camel@localhost>
 <5178816D.3000309@asianux.com> <5178ABA2.4030109@linux.vnet.ibm.com>
 <20130425062539.GA421@iris.ozlabs.ibm.com> <51791076.9040405@asianux.com>
 <5179DF37.8020407@linux.vnet.ibm.com>
In-Reply-To: <5179DF37.8020407@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
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

On 2013年04月26日 09:58, Mike Qiu wrote:
> 于 2013/4/25 19:16, Chen Gang 写道:
>> On 2013年04月25日 14:25, Paul Mackerras wrote:
>>> On Thu, Apr 25, 2013 at 12:05:54PM +0800, Mike Qiu wrote:
>>>>> This has block my work now
>>>>> So I hope you can take a look ASAP
>>>>> Thanks
>>>>> :)
>>>>>
>>>>> Mike
>>> As a quick fix, turn on CONFIG_KVM_BOOK3S_64_HV.  That will eliminate
>>> the immediate problem.
>> Yes, just as my original reply to Mike to bypass it, but get no reply, I
>> guess he has to face the CONFIG_KVM_BOOK3S_64_PR.
>>
>> Now, I am just fixing it, when I finish one patch, please help check.
> Actually, I have compile pass by your patch, but I see Micheal Neuling's
> reply,
> I just stop to do that, and wait for you new patch :)
> 

I am just continuing (before get fixed, I should continue)


> Now I will use your V2 patch to build

Please see the discussion of patch v2, it still has another issues, but
I am still trying (I guess Michael is just checking).

:-)

-- 
Chen Gang

Asianux Corporation
