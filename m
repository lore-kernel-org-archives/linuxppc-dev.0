Return-Path: <nfont@austin.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B81581007D2
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 03:15:23 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA2GBjD2014564
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Nov 2009 11:11:45 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA2GFKtp098690
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Nov 2009 11:15:20 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA2GFK8v031523
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Nov 2009 11:15:20 -0500
Message-ID: <4AEF0597.9030805@austin.ibm.com>
Date: Mon, 02 Nov 2009 10:15:19 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 6/6 v5] CPU DLPAR Handling
References: <4AE8ADCF.6090104@austin.ibm.com>	
	<4AE8B0B1.4020102@austin.ibm.com>
	<1256786763.26770.46.camel@pasglop>
In-Reply-To: <1256786763.26770.46.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2009-10-28 at 15:59 -0500, Nathan Fontenot wrote:
> 
>> +#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
>> +static ssize_t cpu_probe(const char *buf, size_t count)
> 
> dlpar_cpu_probe() pls
> 
>> +static ssize_t cpu_release(const char *buf, size_t count)
>> +{
> 
> Ditto.
> 
> Or else in system.map, backtraces, etc... it's hard to figure out off
> hand where it's dying :-)

Good point, I'll fix this.

-Nathan

> 
> Cheers,
> Ben.
> 
> 
