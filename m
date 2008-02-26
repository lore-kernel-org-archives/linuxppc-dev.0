Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18371.54796.174623.988521@cargo.ozlabs.ibm.com>
Date: Tue, 26 Feb 2008 20:04:12 +1100
From: Paul Mackerras <paulus@samba.org>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH][OF] Add of_device_is_available function
In-Reply-To: <20080223202357.20a12b84@zod.rchland.ibm.com>
References: <20080223155823.2c85d829@zod.rchland.ibm.com>
	<20080223185904.757c2884@zod.rchland.ibm.com>
	<20080223202357.20a12b84@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer writes:

> +	status = of_get_property(device, "status", NULL);
> +	if (status == NULL)
> +		return 1;
> +
> +	if (!strcmp(status, "okay") || !strcmp(status, "ok"))

It would probably be good to defend against the possibility that the
property isn't null-terminated (for example if its length is zero).

Paul.
