Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09785B7D49
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Apr 2010 17:39:01 +1000 (EST)
References: <594EC076-62C6-473D-9AF2-47AEE4B57ED3@suse.de>
	<1271827490-sup-48@au1.ibm.com>
	<12E39DE6-0957-43CD-8DD4-24970AAF45D3@suse.de>
	<1272331742-sup-1208@au1.ibm.com>
Message-Id: <13932595-5EF2-4C1D-B07D-CB24AEB7BCF7@suse.de>
From: Alexander Graf <agraf@suse.de>
To: Ian Munsie <imunsie@au1.ibm.com>
In-Reply-To: <1272331742-sup-1208@au1.ibm.com>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 7E18)
Subject: Re: perf top broken on ppc64
Date: Tue, 27 Apr 2010 08:39:18 +0100
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


Am 27.04.2010 um 02:30 schrieb Ian Munsie <imunsie@au1.ibm.com>:

>>> I'm using 32 bit userland and 64 bit kernel on a PowerPC box and  
>>> it's working for me.
>>> Are you building perf from the tip tree?
>>
>> I'm using kvm.git which is pretty close to tip. The version says  
>> something 2.6.34-rc3'ish. Has anything significantly changed since  
>> then?
>>
>> Either way - I'll give it a try.
>
>
> Hey Alex,
>
> Did perf from the tip tree work for you?

Howdy,

Sorry - I left for vacation without replying :).

I tried perf from tip with kvm.git kernel and that did show the same  
effects. I didn't get around to also try to run the tip kernel, and  
won't be within this week :o


Greetings from Gran Canaria,

Alex

>
