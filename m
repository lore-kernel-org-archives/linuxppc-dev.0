Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17922.27905.439387.814432@cargo.ozlabs.ibm.com>
Date: Thu, 22 Mar 2007 22:48:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: Tony Vroon <chainsaw@gentoo.org>
Subject: Re: [PATCH 2.6.22] [resend] Allow PMU LED control on PowerMac 7,
	2 and 7, 3
In-Reply-To: <20070318201110.181165B80F1@ganymede.vroon.org>
References: <20070318201110.181165B80F1@ganymede.vroon.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tony Vroon writes:

>  	if (strncmp(model, "PowerBook", strlen("PowerBook")) != 0 &&
> -	    strncmp(model, "iBook", strlen("iBook")) != 0) {
> +	    strncmp(model, "iBook", strlen("iBook")) != 0 &&
> +	    strncmp(model, "PowerMac7,2", strlen("PowerMac7,2")) != 0 &&
> +	    strncmp(model, "PowerMac7,3", strlen("PowerMac7,3")) != 0) {

Since we only want to accept "PowerMac7,2" or "PowerMac7,3", and not
any longer strings ("PowerMac7,30" for instance), I think the
comparisons you have added should use strcmp rather than strncmp.

Paul.
