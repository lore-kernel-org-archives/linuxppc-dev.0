Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 34603B7C06
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Apr 2010 19:29:52 +1000 (EST)
Subject: Re: perf top broken on ppc64
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1271827490-sup-48@au1.ibm.com>
Date: Wed, 21 Apr 2010 11:29:44 +0200
Message-Id: <12E39DE6-0957-43CD-8DD4-24970AAF45D3@suse.de>
References: <594EC076-62C6-473D-9AF2-47AEE4B57ED3@suse.de>
	<1271827490-sup-48@au1.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>
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


On 21.04.2010, at 07:29, Ian Munsie wrote:

> Excerpts from Alexander Graf's message of Wed Apr 21 09:21:36 +1000 =
2010:
>> Hi,
>>=20
>> While trying to find out performance bottlenecks in KVM for PowerPC I
>> figured I'd try and use "perf top" to see what's going on in the
>> system. This works great on my G4, but doesn't on the Powerstation
>> (970MP).
>>=20
>> The only weird thing I can imagine about this setup is that I'm
>> running 32 bit userland on a 64 bit kernel. So I went ahead and
>> compiled perf for ppc64 - without any change:
>=20
> I'm using 32 bit userland and 64 bit kernel on a PowerPC box and it's =
working for me.
> Are you building perf from the tip tree?

I'm using kvm.git which is pretty close to tip. The version says =
something 2.6.34-rc3'ish. Has anything significantly changed since then?

Either way - I'll give it a try.


Alex
