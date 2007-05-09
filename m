Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: PATCH: free mm if spufs_fill_dir() failed
Date: Wed, 9 May 2007 16:08:26 +1000
References: <463B6D16.9050400@linux.vnet.ibm.com>
In-Reply-To: <463B6D16.9050400@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200705091608.26934.jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sebastian,

> In case spufs_fill_dir() fails only put_spu_context()
> gets called for cleanup and the acquired mm_struct never gets freed.

Good catch. However - could we do the mmput in the context destroy path 
instead?

Also, you're probably better-off sending patches inline. It makes 
commenting on the patch much easier for some mailers.

Cheers,


Jeremy
