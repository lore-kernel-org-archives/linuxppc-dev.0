Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB457DE617
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 01:07:23 +1100 (EST)
Message-ID: <48EF61A2.3020006@billgatliff.com>
Date: Fri, 10 Oct 2008 09:07:30 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [RFC 1/6] [PWM] Generic PWM API implementation
References: <cover.1223482372.git.bgat@billgatliff.com>	<4b5c3aa2b1bc2b7efad834da49c2dec8c0a8726b.1223482372.git.bgat@billgatliff.com>
	<1223608853.8157.129.camel@pasglop>
In-Reply-To: <1223608853.8157.129.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2008-10-08 at 11:43 -0500, Bill Gatliff wrote:
>> Signed-off-by: Bill Gatliff <bgat@billgatliff.com>
>> ---
> 
> And you haven't provided -any- changeset comment. That isn't good :-)

What's the easiest way to do that with git?

I'm using git-format-patch and git-send-email to produce the changeset emails
themselves, after extensive use of git-add --interactive and git-rebase
--interactive to get rid of the "mundane" commit stuff that I do because of my
highly interrupt-driven workflow.

Should I just edit the files that come out of git-format-patch?


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
