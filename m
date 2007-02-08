Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <200702070945.56056.sr@denx.de>
References: <200702070945.56056.sr@denx.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BC3095EE-64C2-4704-9155-9C354B96C268@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ppc: Fix booke watchdog initialization
Date: Thu, 8 Feb 2007 00:07:36 -0600
To: Stefan Roese <sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 7, 2007, at 2:45 AM, Stefan Roese wrote:

> [PATCH] ppc: Fix booke watchdog initialization
>
> Fix two problems in the book-e watchdog driver.
>
> a) The 4xx default period was defined wrong
> b) Clear status before enabling the watchdog exception
>
> Signed-off-by: Stefan Roese <sr@denx.de>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

(Looks like Paul grabbed this before I did :)

- k
