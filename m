Return-Path: <scottwood@freescale.com>
Message-ID: <46CB0ED8.50806@freescale.com>
Date: Tue, 21 Aug 2007 11:12:08 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 09/20] bootwrapper: Declare udelay() in ops.h.
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820173955.GH30562@ld0162-tx32.am.freescale.net>
	<20070821023943.GI15469@localhost.localdomain>
In-Reply-To: <20070821023943.GI15469@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Mon, Aug 20, 2007 at 12:39:55PM -0500, Scott Wood wrote:
> 
>>Declarations in various users are removed.
>>
>>Signed-off-by: Scott Wood <scottwood@freescale.com>
> 
> 
> Hrm... it should go in a header, certainly, but I wonder if io.h would
> be more suitable than the already rather bloated ops.h.

It's not really I/O either...  Maybe we should make a misc.h to put 
stuff in that doesn't fit anywhere else and doesn't really warrant its 
own header file?

-Scott
