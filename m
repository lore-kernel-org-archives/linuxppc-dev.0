Return-Path: <msm@freescale.com>
Subject: Re: [HACK] add sandpoint + flattened dt support to arch/powerpc/boot
From: Matthew McClintock <msm@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060518002142.GA23182@mag.az.mvista.com>
References: <20060518002142.GA23182@mag.az.mvista.com>
Content-Type: text/plain
Date: Thu, 18 May 2006 08:47:01 -0500
Message-Id: <1147960021.7607.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-17 at 17:21 -0700, Mark A. Greer wrote:
> +void *
> +dt_find_prop_by_name(void *dt_blob, char *full_name, u32 *val_sizep) 

Is there a reason you are not using of_get_flat_dt_prop() instead of
implementing your own version?

-Matthew
