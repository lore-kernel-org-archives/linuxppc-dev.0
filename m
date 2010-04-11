Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3D16B7D1B
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Apr 2010 15:29:45 +1000 (EST)
Message-ID: <4BC15E42.6090202@embedded-sol.com>
Date: Sun, 11 Apr 2010 08:29:38 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Ethernet support missing p1020rdb.dts
References: <4BBDB59C.4050402@embedded-sol.com>
	<972C2D0A-EE3F-4183-998C-E1763D46DBE4@kernel.crashing.org>
In-Reply-To: <972C2D0A-EE3F-4183-998C-E1763D46DBE4@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>, Sandeep.Kumar@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

On 4/9/2010 8:43 AM, Kumar Gala wrote:
> On Apr 8, 2010, at 5:53 AM, Felix Radensky wrote:
>
>   
>> Hi,
>>
>> I've just noticed that ethernet nodes are missing in p1020rdb device tree.
>> Are there any known problems with ethernet controllers on p1020rdb ?
>>     
> I'd say its not problems, its support for the newer controller on p1020rdb.  At the time the .dts the kernel didn't have support.  I'm not 100% clear on its current state.
>
> - k
> _______________________________________________
>
>   

AFAICS support for eTSEC2.0 was added by commits 
46ceb60ca80fa07703bc6eb8f4651f900dff5a82
and 1d2397d742b7a2b39b2f09dd9da3b9d1463f55e9. Assuming the support is 
complete, what should
be changed in ethernet nodes from p2020rdb.dts to support p1020rdb 
except obvious changes in
compatible properties ?

I'm going to receive a couple of p1020rdb systems soon, they would be 
pretty useless without
a working ethernet.

Thanks.

Felix.
