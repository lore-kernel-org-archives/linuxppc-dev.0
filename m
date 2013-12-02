Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 6D0142C009E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2013 20:56:07 +1100 (EST)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1812\))
Subject: Re: 3.13 Oops on ppc64_cpu --smt=off
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <529C0614.6070708@linux.vnet.ibm.com>
Date: Mon, 2 Dec 2013 10:57:21 +0100
Message-Id: <6466B80A-5F19-4D1B-968F-AE19B28EF8DB@suse.de>
References: <9C236EE3-BB04-4BF9-ACE0-870A9E97EA0F@suse.de>
 <529C0614.6070708@linux.vnet.ibm.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 02.12.2013, at 05:01, Preeti U Murthy <preeti@linux.vnet.ibm.com> =
wrote:

> Hi,
>=20
> On 11/30/2013 11:15 PM, Alexander Graf wrote:
>> Hi Ben,
>>=20
>> With current linus master (3.13-rc2+) I'm facing an interesting issue =
with
>=20
> SMT disabling on p7. When I trigger the cpu offlining it works as =
expected,
> but after a few seconds the machine goes into an oops as you can see =
below.
>>=20
>> It looks like a null pointer dereference.
>=20
> tip/sched/urgent has the below fix. Can you please apply the following =
it and
> check if the issue gets resolved?  A similar issue was reported =
earlier as

I've disabled NO_HZ now on that machine which also "fixed" it for me. =
Unfortunately I can't reboot that box for at least the next week now to =
test whether the patch does fix the issue.


Alex
