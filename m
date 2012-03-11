Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E4E3FB6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2012 10:00:33 +1100 (EST)
Date: Sun, 11 Mar 2012 15:56:21 -0700 (PDT)
Message-Id: <20120311.155621.699600599796181447.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: linux-next: manual merge of the net-next tree with the powerpc
 tree
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120309174416.2b936c5a4a116d56f9a25502@canb.auug.org.au>
References: <20120309133646.fb8cc30d8c2fd0ef7784d72c@canb.auug.org.au>
 <20120308.221534.712157352097242982.davem@davemloft.net>
 <20120309174416.2b936c5a4a116d56f9a25502@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, paulus@samba.org, joe@perches.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 9 Mar 2012 17:44:16 +1100

> On Thu, 08 Mar 2012 22:15:34 -0800 (PST) David Miller <davem@davemloft.net> wrote:
>>
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date: Fri, 9 Mar 2012 13:36:46 +1100
>> 
>> > Today's linux-next merge of the net-next tree got a conflict in
>> > drivers/net/ethernet/ibm/iseries_veth.c between commit e92a665949f6
>> > ("net: powerpc: remove the legacy iSeries ethernet driver") from the
>> > powerpc tree and commit 41de8d4cff21 ("drivers/net: Remove alloc_etherdev
>> > error messages") from the net-next tree.
>> > 
>> > I just removed the file.
>> 
>> If it makes life easier for anyone I can put the driver removal patch
>> into net-next.
> 
> In this case, I think it will actually help, thanks.  Note that it won;t
> apply cleanly to your tree, but the fixup is easy :-)
> 
> And I discovered that "git am" doesn't like the style of patch I did
> (without the body of the deleted file).  If you just delete
> drivers/net/ethernet/ibm/iseries_veth.c before trying to apply the patch
> it will probably work.

I took care of this the other night.
