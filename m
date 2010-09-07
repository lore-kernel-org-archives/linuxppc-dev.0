Return-Path: <davem@davemloft.net>
Date: Mon, 06 Sep 2010 18:29:35 -0700 (PDT)
Message-Id: <20100906.182935.212701145.davem@davemloft.net>
To: julia@diku.dk
Subject: Re: [PATCH 1/2] drivers/net/fs_enet/fs_enet-main.c: Add
	of_node_put to avoid memory leak
From: David Miller <davem@davemloft.net>
In-Reply-To: <1283595164-29146-1-git-send-email-julia@diku.dk>
References: <1283595164-29146-1-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	vbordug@ru.mvista.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>
Date: Sat,  4 Sep 2010 12:12:43 +0200

> In this case, a device_node structure is stored in another structure that
> is then freed without first decrementing the reference count of the
> device_node structure.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
...
> Signed-off-by: Julia Lawall <julia@diku.dk>

Applied.
