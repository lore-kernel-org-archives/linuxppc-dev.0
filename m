Return-Path: <msm@freescale.com>
Subject: Re: [PATCH/RFC] Add cmd_wrap_dts rules to arch/powerpc/boot/Makefile
From: Matthew McClintock <msm@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <1161237001.4992.5.camel@localhost>
References: <20061019002635.GA2356@mag.az.mvista.com>
	<1161237001.4992.5.camel@localhost>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 00:58:00 -0500
Message-Id: <1161237481.4992.11.camel@localhost>
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

On Thu, 2006-10-19 at 00:50 -0500, Matthew McClintock wrote:
>         $(obj)/$(CONFIG_SANDPOINT): vmlinux $(wrapperbits)
>                 $(call cmd,wrap_dts,`echo $CONFIG_SANDPOINT | awk
> '{print substr($1, 8)}'`) 

The $(CONFIG_SANDPOINT) bits should ideally be renamed to
$(CONFIG_TARGET) or something....

-Matthew
