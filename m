Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17660.48525.873588.173047@cargo.ozlabs.ibm.com>
Date: Tue, 5 Sep 2006 09:58:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Unwire set/get_robust_list
In-Reply-To: <1157409148.2473.209.camel@shinybook.infradead.org>
References: <jeodtvfn4x.fsf@sykes.suse.de>
	<1157409148.2473.209.camel@shinybook.infradead.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> Something like this? 

Don't we need an access_ok() test in there?  Otherwise, looks fine to
me.

Thanks,
Paul.
