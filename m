From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15278.40161.431833.765393@cargo.ozlabs.ibm.com>
Date: Mon, 24 Sep 2001 12:39:29 +1000 (EST)
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: linuxppc-commit@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] gcc3 compatibility and debugger support
In-Reply-To: <200109061932.OAA12306@lists.linuxppc.org>
References: <200109061932.OAA12306@lists.linuxppc.org>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl writes:

>  	current_set[smp_processor_id()] = new;
> +#else
> +	current_set[0] = new;
>  #endif /* CONFIG_SMP */

Yuck.  Just put the #endif before the line that sets current_set[].
smp_processor_id() is 0 on UP.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
