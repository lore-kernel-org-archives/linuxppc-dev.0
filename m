Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 07D01DDFA4
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 02:00:17 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: OF compatible MTD platform RAM driver ?
Date: Tue, 11 Mar 2008 10:00:10 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B041854B3@ismail.innsys.innovsys.com>
In-Reply-To: <20080311004545.GI11559@localhost.localdomain>
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<DCEAAC0833DD314AB0B58112AD99B93B0418505E@ismail.innsys.innovsys.com>
	<20080311004545.GI11559@localhost.localdomain>
From: "Rune Torgersen" <runet@innovsys.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org, ben@simtec.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Mon, Mar 10, 2008 at 12:00:22PM -0500, Rune Torgersen wrote:
>> We ran ito the same issue.
>> We did option 3, as it was efinetly the easiest,
>=20
> I think this is the best option in principle.
>=20
>> here is the sram entry in our dts:
>=20
> Except that your implementation of it is not good.
>=20
> You're relying on the old obsolete flash binding with the "probe-type"
> field.  The solution should be adapted to the new approach which uses
> values in the "compatible" field to indicate various sorts of flash
> device.

Yea, I know. But it was the easiest way of doing it at the time we did
our port....
In a timecrunch, easier is sometimes better than correct. :)
