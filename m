Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6381B7D68
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Apr 2010 11:30:58 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id o3R1R7tg029987
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Apr 2010 11:27:07 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3R1O7F21499240
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Apr 2010 11:24:09 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3R1Usaf014033
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Apr 2010 11:30:54 +1000
Content-Type: text/plain; charset=UTF-8
Subject: Re: perf top broken on ppc64
From: Ian Munsie <imunsie@au1.ibm.com>
To: Alexander Graf <agraf@suse.de>
In-reply-to: <12E39DE6-0957-43CD-8DD4-24970AAF45D3@suse.de>
References: <594EC076-62C6-473D-9AF2-47AEE4B57ED3@suse.de>
	<1271827490-sup-48@au1.ibm.com>
	<12E39DE6-0957-43CD-8DD4-24970AAF45D3@suse.de>
Date: Tue, 27 Apr 2010 11:30:21 +1000
Message-Id: <1272331742-sup-1208@au1.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML Mailing List <linux-kernel@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > I'm using 32 bit userland and 64 bit kernel on a PowerPC box and it's working for me.
> > Are you building perf from the tip tree?
> 
> I'm using kvm.git which is pretty close to tip. The version says something 2.6.34-rc3'ish. Has anything significantly changed since then?
> 
> Either way - I'll give it a try.


Hey Alex,

Did perf from the tip tree work for you?

Cheers,
-Ian
