Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 46B65DDF8E
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 03:15:51 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l99HFmYG029321
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Oct 2007 13:15:49 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l99HFm5E381440
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Oct 2007 11:15:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l99HFmUv017490
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Oct 2007 11:15:48 -0600
Date: Tue, 9 Oct 2007 12:15:47 -0500
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch v2] PS3: Add os-area database routines
Message-ID: <20071009171547.GH4350@austin.ibm.com>
References: <20071006213542.311447584@am.sony.com>
	<20071006213542.954029915@am.sony.com>
	<470AD44C.5080305@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <470AD44C.5080305@am.sony.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 08, 2007 at 06:07:24PM -0700, Geoff Levand wrote:
> Subject: PS3: Add os-area database routines
> 
> Add support for a simple tagged database in the PS3 flash rom
> os-area.  The database allows the flash rom os-area to be shared
> between a bootloader and installed operating systems.   The
> application ps3-flash-util or the library libps3-utils from the
> ps3-utils package can be used for userspace database operations.

Perhaps I missed the discussion; but .. out of general curiosity,
what is the relation between this and the ppc_md.nvram_* system?
I note that pseries, powermac, chrp, celleb implement the nvram calls,
but cell and ps3 do not. So clearly, whatever this is, its not 
layered on top of nvram?

FWIW, I don't quite understand the nvram system; it seems to have
partitions; one part is an "os area", and a chuck of it is set 
up as a file system.

So I'm wondering -- wouldn't the DB os-area be "generically 
interesting" to other ppowerpc platforms? Maybe even other arches?
And why isn't this built on top of the nvram structure? ... etc?

--linas
