Return-Path: <eric.dumazet@gmail.com>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217]) by ozlabs.org (Postfix) with ESMTP id C4DBCB7D41
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Apr 2010 03:47:42 +1000 (EST)
Received: by bwz9 with SMTP id 9so137144bwz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Apr 2010 10:47:40 -0700 (PDT)
Subject: RE: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
From: Eric Dumazet <eric.dumazet@gmail.com>
To: John Linn <John.Linn@xilinx.com>
In-Reply-To: <bf8eac92-5008-4c1f-9b99-0199e62436fa@SG2EHSMHS010.ehs.local>
References: <d9134316-bd07-46a8-91d4-c30f27baeb60@SG2EHSMHS007.ehs.local>
	<1270502993.9013.36.camel@edumazet-laptop>
	<2fefb2a2-d0dc-461d-ac8c-3e7d177b7cf8@VA3EHSMHS032.ehs.local>
	<1270573233.2081.47.camel@edumazet-laptop>
	<bf8eac92-5008-4c1f-9b99-0199e62436fa@SG2EHSMHS010.ehs.local>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Apr 2010 19:47:37 +0200
Message-ID: <1270576057.2081.100.camel@edumazet-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	John Tyner <jtyner@cs.ucr.edu>, michal.simek@petalogix.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> 
> Yes I see how it's used, but it only allows you to reserve 2 bytes in the skb with no options.


Really ? This would be a bug !

__alloc_skb() uses kmalloc(XXXX), this gives you the guarantee you want,
or maybe comment you wrote is not what is _really_ necessary ?

/* Align the IP data in the packet on word boundaries as MicroBlaze
 * needs it.
 */
