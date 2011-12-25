Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 06D1DB6FC5
 for <linuxppc-dev@ozlabs.org>; Sun, 25 Dec 2011 21:48:35 +1100 (EST)
Subject: Re: p1020 unstable with 3.2
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1324709633.6632.20.camel@pasglop>
Date: Sun, 25 Dec 2011 11:48:27 +0100
Message-Id: <025812DC-AB8E-4B60-9B16-50C3DE4DD561@suse.de>
References: <0048E411-D82D-4EA4-B9BA-EF233AC6ED34@suse.de>
 <1324709633.6632.20.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
 Fleming Andy-AFLEMING <afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 24.12.2011, at 07:53, Benjamin Herrenschmidt wrote:

> On Fri, 2011-12-23 at 17:54 +0100, Alexander Graf wrote:
>> Hi guys,
>> 
>> While trying to test my latest patch queue for ppc kvm, I realized
>> that even though the device trees got updated, the p1020 box still is
>> unstable. The trace below is the one I've seen the most. It only
>> occurs during network I/O which happens a lot on that box, since I'm
>> running it using NFS root.
>> 
>> As for configuration, I use kumar's "merge" branch from today and the
>> p1020rdb.dts device tree provided in that tree.
>> 
>> The last known good configuration I'm aware of is 3.0.
>> 
>> Any ideas what's going wrong here?
> 
> Try SLAB instead of SLUB and let me know. It -could- be a bogon in SLUB
> that should be fixed upstream now but I think did hit 3.2

Yup, things seem a lot more stable with SLAB now :).


Alex
