Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] setup_kcore(): Fix incorrect function name in panic()
	call.
Date: Fri, 17 Nov 2006 14:58:10 +1100
References: <Pine.LNX.4.62.0611170446250.16998@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0611170446250.16998@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611171458.11245.jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert,

> -			panic("mem_init: kmalloc failed\n");
> +			panic("setup_kcore: kmalloc failed\n");

How about:
	
	panic("%s: kmalloc_failed\n", __FUNCTION__);

To prevent this happening again?


Jeremy
