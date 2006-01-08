Return-Path: <hollis@penguinppc.org>
In-Reply-To: <1136695956.30123.44.camel@localhost.localdomain>
References: <1136695956.30123.44.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fe4d9bc576d696dfea0bc1b2a742307d@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Sat, 7 Jan 2006 22:55:48 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Fix PowerMac sound i2c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jan 7, 2006, at 10:52 PM, Benjamin Herrenschmidt wrote:

> +        data.block[0] = len;
> +	memcpy(&data.block[1], values, len);

Seem to be mixing tabs and spaces here (in both *_write_block 
functions).

-Hollis
