Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 148DCB7CF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Apr 2010 15:29:49 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id o3L5Tk50020454
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2010 15:29:46 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3L5ND13508034
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2010 15:23:13 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3L5Tmhs032324
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2010 15:29:48 +1000
Content-Type: text/plain; charset=UTF-8
Subject: Re: perf top broken on ppc64
From: Ian Munsie <imunsie@au1.ibm.com>
To: Alexander Graf <agraf@suse.de>
In-reply-to: <594EC076-62C6-473D-9AF2-47AEE4B57ED3@suse.de>
References: <594EC076-62C6-473D-9AF2-47AEE4B57ED3@suse.de>
Date: Wed, 21 Apr 2010 15:29:19 +1000
Message-Id: <1271827490-sup-48@au1.ibm.com>
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

Excerpts from Alexander Graf's message of Wed Apr 21 09:21:36 +1000 2010:
> Hi,
> 
> While trying to find out performance bottlenecks in KVM for PowerPC I
> figured I'd try and use "perf top" to see what's going on in the
> system. This works great on my G4, but doesn't on the Powerstation
> (970MP).
> 
> The only weird thing I can imagine about this setup is that I'm
> running 32 bit userland on a 64 bit kernel. So I went ahead and
> compiled perf for ppc64 - without any change:

I'm using 32 bit userland and 64 bit kernel on a PowerPC box and it's working for me.
Are you building perf from the tip tree?

Cheers,
-Ian
