Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17454.25885.271586.671454@cargo.ozlabs.ibm.com>
Date: Sat, 1 Apr 2006 22:33:49 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: whitespace cleanups (try 2)
In-Reply-To: <200603311521.55855.nfont@austin.ibm.com>
References: <200603311509.25712.nfont@austin.ibm.com>
	<200603311521.55855.nfont@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Fontenot writes:

> Let's try this again with a patch that will apply a little cleaner

Ummm... unfortunately your mailer is still wrapping lines:

> @@ -327,16 +323,17 @@ int eeh_dn_check_failure(struct device_n
>         if (pdn->eeh_mode & EEH_MODE_ISOLATED) {
>                 pdn->eeh_check_count ++;
>                 if (pdn->eeh_check_count >= EEH_MAX_FAILS) {
> -                       printk (KERN_ERR "EEH: Device driver ignored %d bad 
> reads, panicing\n",

Paul.
