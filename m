Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: John Rose <johnrose@austin.ibm.com>
Subject: Re: [PATCH] powerpc: force 4k update_flash block and list sizes 
In-reply-to: <1162960202.14254.3.camel@sinatra.austin.ibm.com> 
References: <1162943615.13499.15.camel@sinatra.austin.ibm.com>
	<20286.1162951582@neuling.org>
	<1162960202.14254.3.camel@sinatra.austin.ibm.com>
Date: Wed, 08 Nov 2006 15:39:04 +1100
Message-ID: <945.1162960744@neuling.org>
Sender: mikey@neuling.org
Cc: External List <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <1162960202.14254.3.camel@sinatra.austin.ibm.com> you wrote:
> > kmem_cache_destroy doesn't return anything.
> 
> Good call!  How's this:
<snip>
> +	if (flash_block_cache) {
> +		rc = kmem_cache_destroy(flash_block_cache);
> +		if (rc)
> +			printk(KERN_WARNING "%s: cache memory leak\n",
> +					__FUNCTION__);
> +	}

Arrh, did anything change?

Mikey
