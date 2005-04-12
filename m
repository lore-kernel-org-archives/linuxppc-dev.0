Return-Path: <linville@bilbo.tuxdriver.com>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	by ozlabs.org (Postfix) with ESMTP id DA39267A64
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 23:22:47 +1000 (EST)
Date: Tue, 12 Apr 2005 08:24:07 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Daniel Ann <ktdann@gmail.com>
Message-ID: <20050412122405.GA27920@tuxdriver.com>
References: <9b7ca6570504120138738b554f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9b7ca6570504120138738b554f@mail.gmail.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Trying to understand alloc_skb()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Apr 12, 2005 at 05:38:01PM +0900, Daniel Ann wrote:

> My problem is that, kernel dies with "alloc_skb called nonatomically
> from interrupt c00ba718" message. After browsing mailing list, I think
> its to do with not providing it with enough locks prior.

You may want to consider dev_alloc_skb...
-- 
John W. Linville
linville@tuxdriver.com
