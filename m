Return-Path: <mgreer@mvista.com>
Date: Mon, 19 Jun 2006 15:28:31 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: [PATCH] mpic: add support for Time-Of-Day-Clock (TODC)
Message-ID: <20060619222831.GA548@mag.az.mvista.com>
References: <20060619210040.GA17984@mag.az.mvista.com>
	<1150751881.31303.87.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1150751881.31303.87.camel@basalt.austin.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 19, 2006 at 04:18:00PM -0500, Hollis Blanchard wrote:
> On Mon, 2006-06-19 at 14:00 -0700, Mark A. Greer wrote:
> > 
> > + * In order to break the assumption that the RTC and NVRAM are accessed by
> > + * the same mechanism, you need to explicitly set 'ppc_md.rtc_read_val' and
> > + * 'ppc_md.rtc_write_val', otherwise the values of 'ppc_md.rtc_read_val'
> > + * and 'ppc_md.rtc_write_val' will be used. 
> 
> I'm guessing the second references should be "nvram_read/write_val"
> instead.

Hrm, yeah, the sentence would make sense then.

I'll repost the patch.

Mark
