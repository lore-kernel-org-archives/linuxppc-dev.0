Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5042ADDDE6
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 06:11:31 +1100 (EST)
Date: Sun, 2 Dec 2007 13:15:14 -0600
From: Olof Johansson <olof@lixom.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 2/2] [POWERPC] Use new machine_xxx_initcall hooks in
	platform code
Message-ID: <20071202191514.GC12415@lixom.net>
References: <20071202061028.21193.39309.stgit@trillian.secretlab.ca>
	<20071202061033.21193.64818.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071202061033.21193.64818.stgit@trillian.secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 01, 2007 at 11:10:33PM -0700, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> This patch makes the platform code use the new machine-specific initcall
> hooks.  This has the advantage of not needing to explicitly test
> machine_is() at the top of every initcall function.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

PA Semi parts:

Acked-by: Olof Johansson <olof@lixom.net>

Overall I approve of the approach as well, looks like a good idea.
I tried building all defconfigs, they pass.


-Olof
