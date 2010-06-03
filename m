Return-Path: <anton@ozlabs.org>
Date: Thu, 3 Jun 2010 14:20:19 +1000
From: Anton Blanchard <anton@samba.org>
To: Wayne Boyer <wayneb@linux.vnet.ibm.com>
Subject: Re: [PATCH] [SCSI] ipr: Fix stack overflow in ipr_format_resource_path
Message-ID: <20100603042019.GI28295@kryten>
References: <20100602111658.GH28295@kryten>
	<4C072C18.4030005@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C072C18.4030005@linux.vnet.ibm.com>
Cc: betabandido@gmail.com, linux-scsi@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Wayne,

> We also saw a variation of this problem last week and I have an alternative
> patch that I'd prefer over this one.  I'll post the patch in a separate
> email.

Thanks. Can you get it into -stable too? As you can see users are hitting it.

Anton
