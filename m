Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C99FA2C00FE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2013 19:34:01 +1000 (EST)
Message-ID: <517B9B53.2030502@asianux.com>
Date: Sat, 27 Apr 2013 17:33:07 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] PowerPC: kernel: compiling issue, make additional
 room in exception vector area
References: <5177965D.9090406@linux.vnet.ibm.com>
 <20130424083142.GB26834@concordia> <51779941.8080403@linux.vnet.ibm.com>
 <30651.1366799858@ale.ozlabs.ibm.com> <1366807638.5911.2.camel@localhost>
 <5178816D.3000309@asianux.com> <5178ABA2.4030109@linux.vnet.ibm.com>
 <20130425062539.GA421@iris.ozlabs.ibm.com> <517918AB.4020508@asianux.com>
 <30269.1366931768@ale.ozlabs.ibm.com> <5179D302.9060203@asianux.com>
 <5179D5D8.8080102@asianux.com> <5179DA23.8000407@asianux.com>
 <5179E056.2000709@linux.vnet.ibm.com> <5179E11F.8010007@asianux.com>
 <5179EFB6.3090602@linux.vnet.ibm.com> <5179F39C.5020408@asianux.com>
 <5179F7B8.5010701@asianux.com> <5179FA8E.9090501@linux.vnet.ibm.com>
 <517B9A4D.1020502@gmail.com> <517B9B2B.30007@linux.vnet.ibm.com>
In-Reply-To: <517B9B2B.30007@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: sfr@canb.auug.org.au, Michael Neuling <mikey@neuling.org>, matt@ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Chen Gang F T <chen.gang.flying.transformer@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2013年04月27日 17:32, Mike Qiu wrote:
>>>
>> I think the diff v2 is correct, but is not the best one for this issue.
>>
>> I prefer the Paul's patch for this issue which has better performance
>>
>> :-)
> yes, I use your patch and it can work, also Paul's patch can work too.

Good news.

Bye !

:-)

-- 
Chen Gang

Asianux Corporation
