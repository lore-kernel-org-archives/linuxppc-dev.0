Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 59D3FB7D45
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 May 2010 23:41:51 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o4TDbZTc032309
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 May 2010 07:37:35 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o4TDfjgk128364
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 May 2010 07:41:45 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4TDfjkh006576
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 May 2010 07:41:45 -0600
Date: Sat, 29 May 2010 09:41:43 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mmio_nvram.c users ?
Message-ID: <20100529134143.GL24511@zod.rchland.ibm.com>
References: <1274773439.1931.238.camel@pasglop>
	<20100525110050.GH24511@zod.rchland.ibm.com>
	<1275104704.1931.528.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1275104704.1931.528.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, May 29, 2010 at 01:45:04PM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2010-05-25 at 07:00 -0400, Josh Boyer wrote:
>> On Tue, May 25, 2010 at 05:43:59PM +1000, Benjamin Herrenschmidt wrote:
>> >Hi folks !
>> >
>> >Anybody aware of anything other than Cell using that driver ?
>> >
>> >I'd like to make it a platform driver instead of having something that
>> >pokes at anything that has a "device_type" set to "nvram" (which is
>> >gross and bogus). But I need to know what platforms to fixup...
>> 
>> Why bother?  You could just use either drivers/mtd/devices/{phram.c or slram.c}
>> and get the same functionality at that point, couldn't you?
>
>Won't that break existing userspace ?

Probably.  Maybe we shouldn't have duplicated a driver in our platform code to
begin with.

josh
