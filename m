Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DE50C2C0103
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 11:06:38 +1000 (EST)
Message-ID: <5178816D.3000309@asianux.com>
Date: Thu, 25 Apr 2013 09:05:49 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Mike <qiudayu@linux.vnet.ibm.com>
Subject: Re: "attempt to move .org backwards" still show up
References: <5177965D.9090406@linux.vnet.ibm.com>
 <20130424083142.GB26834@concordia> <51779941.8080403@linux.vnet.ibm.com>
 <30651.1366799858@ale.ozlabs.ibm.com> <1366807638.5911.2.camel@localhost>
In-Reply-To: <1366807638.5911.2.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Cc: sfr@canb.auug.org.au, Michael Neuling <mikey@neuling.org>, matt@ozlabs.org,
 linux-kernel@vger.kernel.org, paulus@samba.org,
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

On 2013年04月24日 20:47, Mike wrote:
> 在 2013-04-24三的 20:37 +1000，Michael Neuling写道：
>> > Mike Qiu <qiudayu@linux.vnet.ibm.com> wrote:
>> > 
>>> > > 于 2013/4/24 16:31, Michael Ellerman 写道:
>>>> > > > On Wed, Apr 24, 2013 at 04:22:53PM +0800, Mike Qiu wrote:
>>>>> > > >> Hi all
>>>>> > > >>
>>>>> > > >> I get an error message when I compile the source code in Power7 platform
>>>>> > > >> use the newest upstream kernel.
>>>> > > > Hi Mike,
>>>> > > >
>>>> > > > It depends on what your .config is. What defconfig are you building?
>>> > > I just copy the config file from /boot/config.* to .config and use make
>>> > > menuconfig
>>> > > change nothing by manually, then save.
>> > 
>> > Can you post the resulting config here?
>> > 
>> > Do you have commit in your tree?
>> >   commit 087aa036eb79f24b856893190359ba812b460f45
>> >   Author: Chen Gang <gang.chen@asianux.com>
>> >   powerpc: make additional room in exception vector area
>> > 
> Sure, that commit certainly in my git tree. And I just try to remove the
> code and re-git clone the source code from upstream, this problem still
> happen.
> I will post the config file as the attachment
> :)
> 
> Thanks

I will try, and plan to get a result within this week (2013-04-28)

Thanks.

-- 
Chen Gang

Asianux Corporation
