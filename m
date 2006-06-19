Return-Path: <hollis@penguinppc.org>
Subject: Re: [PATCH] mpic: add support for Time-Of-Day-Clock (TODC)
From: Hollis Blanchard <hollis@penguinppc.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060619210040.GA17984@mag.az.mvista.com>
References: <20060619210040.GA17984@mag.az.mvista.com>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 16:18:00 -0500
Message-Id: <1150751881.31303.87.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-06-19 at 14:00 -0700, Mark A. Greer wrote:
> 
> + * In order to break the assumption that the RTC and NVRAM are accessed by
> + * the same mechanism, you need to explicitly set 'ppc_md.rtc_read_val' and
> + * 'ppc_md.rtc_write_val', otherwise the values of 'ppc_md.rtc_read_val'
> + * and 'ppc_md.rtc_write_val' will be used. 

I'm guessing the second references should be "nvram_read/write_val"
instead.

-Hollis
