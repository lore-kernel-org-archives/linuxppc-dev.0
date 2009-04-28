Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9936ADDE1A
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 22:09:30 +1000 (EST)
Message-Id: <D2FE35F2-E8A4-4B65-A8CE-DA8CF202EE37@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <2a27d3730904280316l7049bddbie914907b16ccfff6@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 0/5] rapidio: adding memory mapping IO support and misc
	fixes
Date: Tue, 28 Apr 2009 07:06:40 -0500
References: <2a27d3730904280316l7049bddbie914907b16ccfff6@mail.gmail.com>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 28, 2009, at 5:16 AM, Li Yang wrote:

> The patch series add MMIO support to Linux rapidio and fix a few nits.
> The patches cross rapidio, netdev, powerpc sub-systems.  It will be
> good for them to go through one tree.  Probably Andrew?  As the
> previous rapidio patches are mostly merged by you.
>
> - Leo

When you repost use the -n option in git-format-patch so we get a  
sequence # for the patches.

Either Andrew or I can possible pick them up as long as we get the  
right maintainer ACKs.

- k
