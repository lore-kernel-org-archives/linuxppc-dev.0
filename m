Return-Path: <ddaney.cavm@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0449FB6FF5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2012 02:15:04 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so4623720pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2012 09:15:02 -0700 (PDT)
Message-ID: <4FAD3B03.3070109@gmail.com>
Date: Fri, 11 May 2012 09:14:59 -0700
From: David Daney <ddaney.cavm@gmail.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: linux-next: Tree for May 10 (net/phy)
References: <20120510192635.c6f3a55196bbf65f13956e44@canb.auug.org.au>	<4FAC35E2.4060900@xenotime.net>	<CAP=VYLon7XRoh9s==wGYjUPNAYaTk8QQx7FGRnaDR97v+O-zXA@mail.gmail.com>
 <20120510.224352.2149006669429730060.davem@davemloft.net>
In-Reply-To: <20120510.224352.2149006669429730060.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>,
 "rdunlap@xenotime.net" <rdunlap@xenotime.net>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/10/2012 07:43 PM, David Miller wrote:
> From: Paul Gortmaker<paul.gortmaker@windriver.com>
> Date: Thu, 10 May 2012 22:36:55 -0400
>
>> On Thu, May 10, 2012 at 5:40 PM, Randy Dunlap<rdunlap@xenotime.net>  wrote:
>>> On 05/10/2012 02:26 AM, Stephen Rothwell wrote:
>>>
>>>> Hi all,
>>>>
>>>> Changes since 20120508:
>>>
>>>
>>>
>>> ERROR: "of_mdio_find_bus" [drivers/net/phy/mdio-mux.ko] undefined!
>>
>> Not just randconfig, but also powerpc allmodconfig:
>>
>> http://kisskb.ellerman.id.au/kisskb/buildresult/6291463/
>>
>> Adding ppc ML to cc.
>
> Adding the guilty party to the CC:.  This really stinks, especially
> after I did give the patch submitter a hard time about getting the
> dependencies right. :-/

Indeed, how embarrassing.

It looks like Bjørn may have already posted a fix.  I will try to verify 
that it works, and take appropriate action.

Sorry about the screw up,
David Daney
