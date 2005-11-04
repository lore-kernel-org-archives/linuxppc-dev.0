Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 19D7168596
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Nov 2005 21:33:30 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 4 Nov 2005 12:33:22 +0200
References: <200511032039.27395.pantelis.antoniou@gmail.com>
In-Reply-To: <200511032039.27395.pantelis.antoniou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511041133.23086.david.jander@protonic.nl>
Subject: Re: [PATCH] ppc32: Put CPM1 config option
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 03 November 2005 19:39, Pantelis Antoniou wrote:
>[...]
> +config CPM1
> +	bool
> +	depends on 8xx
> +	default y
> +	help
> +	  The CPM1 (Communications Processor Module) is a coprocessor on
> +	  embedded CPUs made by Motorola.  Selecting this option means that
> +	  you wish to build a kernel for a machine with a CPM1 coprocessor
> +	  on it (8xx, 827x, 8560).

Not that the help of a hidden bool is of much importance, but what have the 
mpc827x and mpc8560 to do with a CPM1? Those are PQ2 processors AFAIK.
Why does this option have a help anyway?

Greetings,

-- 
David Jander
