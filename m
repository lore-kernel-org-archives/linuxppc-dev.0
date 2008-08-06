Return-Path: <timur.tabi@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.237])
	by ozlabs.org (Postfix) with ESMTP id E806DDE11D
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 02:46:48 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so6180wra.1
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Aug 2008 09:46:47 -0700 (PDT)
Message-ID: <ed82fe3e0808060946v39992095pfb6b85726b7d307d@mail.gmail.com>
Date: Wed, 6 Aug 2008 11:46:47 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
In-Reply-To: <20080806060239.30717.79273.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>
Cc: miltonm@bga.com, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 6, 2008 at 1:02 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> of_lookup_stdout() is useful for figuring out what device to use as output
> for early boot progress messages.  It returns the node pointed to by the
> linux,stdout-path property in the chosen node.

I thought linux,stdout-path is deprecated are we're supposed to be
using the aliases node instead?

-- 
Timur Tabi
Linux kernel developer at Freescale
