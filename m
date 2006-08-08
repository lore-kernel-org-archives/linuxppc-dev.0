Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17624.10083.56514.758904@cargo.ozlabs.ibm.com>
Date: Tue, 8 Aug 2006 15:55:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: will_schmidt@vnet.ibm.com
Subject: Re: [PATCH] update {g5,iseries,pseries}_defconfigs
In-Reply-To: <1154718328.5748.13.camel@farscape.rchland.ibm.com>
References: <1154718328.5748.13.camel@farscape.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Will Schmidt writes:

> +CONFIG_HW_RANDOM=y

This doesn't do us any good.  It's annoying that it defaults to Y on
all architectures.

> +# CONFIG_SND_AOA is not set
> +# CONFIG_SND_AOA_SOUNDBUS is not set

We want these on for G5s.

> +# CONFIG_USB_APPLEDISPLAY is not set

And probably this too.

Paul.
