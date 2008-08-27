Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F848DDEE3
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 10:38:18 +1000 (EST)
Subject: Re: [PATCH 04/59] CRED: Wrap task credential accesses in the
	PowerPC arch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Howells <dhowells@redhat.com>
In-Reply-To: <20080827134602.19980.59222.stgit@warthog.procyon.org.uk>
References: <20080827134541.19980.61042.stgit@warthog.procyon.org.uk>
	<20080827134602.19980.59222.stgit@warthog.procyon.org.uk>
Content-Type: text/plain
Date: Thu, 28 Aug 2008 09:45:33 +1000
Message-Id: <1219880733.13162.220.camel@pasglop>
Mime-Version: 1.0
Cc: Serge Hallyn <serue@us.ibm.com>, linux-security-module@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-08-27 at 14:46 +0100, David Howells wrote:
> Wrap access to task credentials so that they can be separated more easily from
> the task_struct during the introduction of COW creds.
> 
> Change most current->(|e|s|fs)[ug]id to current_(|e|s|fs)[ug]id().
> 
> Change some task->e?[ug]id to task_e?[ug]id().  In some places it makes more
> sense to use RCU directly rather than a convenient wrapper; these will be
> addressed by later patches.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: James Morris <jmorris@namei.org>
> Acked-by: Serge Hallyn <serue@us.ibm.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linuxppc-dev@ozlabs.org
> ---

Ack.

Ben.
