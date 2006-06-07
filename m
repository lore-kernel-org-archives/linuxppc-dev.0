Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0A5F567B24
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 12:24:47 +1000 (EST)
Date: Tue, 6 Jun 2006 19:24:12 -0700
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH] powerpc: Add udbg-immortal kernel option
Message-ID: <20060607022412.GA5661@pb15.lixom.net>
References: <1149645981.27572.96.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1149645981.27572.96.camel@localhost.localdomain>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 07, 2006 at 12:06:20PM +1000, Benjamin Herrenschmidt wrote:
>  		return;
> +	if (strstr(saved_command_line, "udbg-immortal")) {
> +		printk(KERN_INFO "early console immortal !\n");
> +		return;
> +	}

So it's YOU who add spaces before punctuation all over arch/powerpc!
Please fix. ;-)


-Olof
