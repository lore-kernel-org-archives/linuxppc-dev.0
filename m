Return-Path: <galak@kernel.crashing.org>
Message-Id: <7D62F928-0BAC-49C4-93CC-51E51BCF283E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081018002352.GA9661@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: remove device_type = "board-control"
Date: Mon, 20 Oct 2008 09:48:37 -0500
References: <20081018002352.GA9661@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 17, 2008, at 7:23 PM, Anton Vorontsov wrote:

> We don't want to encourage the bogus device_type usage.
>
> The device type isn't used in the code, so we can simply remove it  
> from
> the documentation and dts files.
>
> Boards should specify proper compatible entries instead.
>
> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

applied

- k
