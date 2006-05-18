Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20060518171159.GD8220@pb15.lixom.net>
References: <1147933251.463191.267166640873.qpush@pokey>
	<20060518171159.GD8220@pb15.lixom.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <06890505-B9A0-42B9-A713-A035FBCBDD1B@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: Add of_parse_dma_window()
Date: Fri, 19 May 2006 01:11:51 +0200
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Acked-by: Olof Johansson <olof@lixom.net>
>
> (I'm assuming you've booted it on POWER4 LPAR and JS20, I don't
> have access to either to make sure it doesn't break there. Main worry
> would be if it lacked ibm,#dma*-properties for some reason.)

The code seems to be resilient against that.  Haven't tested though.


Segher
