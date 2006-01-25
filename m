Return-Path: <schwab@suse.de>
From: Andreas Schwab <schwab@suse.de>
To: Cedric Pradalier <cedric.pradalier@inrialpes.fr>
Subject: Re: [PATCH 001/001 Updated again] PMAC HD runtime blinking control
References: <20060122121907.792abc72.cedric.pradalier@free.fr>
	<1137898193.12998.83.camel@localhost.localdomain>
	<20060123233823.3f0dbad5.cedric.pradalier@inrialpes.fr>
	<1138024037.4907.24.camel@localhost.localdomain>
	<20060124073133.5cab0e93.cedric.pradalier@inrialpes.fr>
	<1138057827.4907.30.camel@localhost.localdomain>
	<20060124222513.48ef0276.cedric.pradalier@inrialpes.fr>
Date: Wed, 25 Jan 2006 12:06:44 +0100
In-Reply-To: <20060124222513.48ef0276.cedric.pradalier@inrialpes.fr> (Cedric
	Pradalier's message of "Tue, 24 Jan 2006 22:25:13 +1000")
Message-ID: <jey814y3az.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cedric Pradalier <cedric.pradalier@inrialpes.fr> writes:

> @@ -427,6 +432,15 @@ static void pmac_ide_kauai_selectproc(id
>  
>  #ifdef CONFIG_BLK_DEV_IDE_PMAC_BLINK
>  
> +MODULE_AUTHOR("Paul Mackerras & Ben. Herrenschmidt");
> +MODULE_DESCRIPTION("Support for IDE interfaces on PowerMacs");
> +MODULE_LICENSE("GPL");
> +
> +static int activity_led = 0;

No need to zero-initialize a static variable.

> @@ -437,8 +451,7 @@ static spinlock_t pmu_blink_lock;
>  static unsigned long pmu_blink_stoptime;
>  static int pmu_blink_ledstate;
>  static struct timer_list pmu_blink_timer;
> -static int pmu_ide_blink_enabled;
> -
> +static int pmu_ide_blink_enabled = 0;

Same.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
