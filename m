Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 57E7EDDE1C
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Dec 2007 17:05:07 +1100 (EST)
Message-ID: <475B858B.9010900@am.sony.com>
Date: Sat, 08 Dec 2007 22:04:59 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
Subject: Re: Stupid git question: adding acked-by
References: <475B7B41.4000505@gmail.com>
In-Reply-To: <475B7B41.4000505@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/08/2007 09:21 PM, Jerry Van Baren wrote:
> OK git gurus, this is something I have not figured out: the best way to 
> add acked-by (or additional signed-off-by) lines to git patches.
> 
> What I'm talking about is when I've applied a patch to my repo and 
> published the change on the list and get an "acked-by" back.  By the 
> time I get the ack, the acked patch may be several patches deep.  My 
> current technique is to reset the repo, edit the patch(es) to add the 
> "acked-by" lines, and then re-apply the patches.  PITA and probably the 
> stupidest way.
> 
> Stacked git should work (effectively does the same thing but more 
> gracefully), but I have not gone that route yet.
> 
> There must be a better way, if only I could find the right (of 137) 
> git-* command...

I keep patches in a repo.  I just update the patch header and commit.

-Geoff 
