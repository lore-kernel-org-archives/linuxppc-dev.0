Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9439CDDF00
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 04:34:20 +1000 (EST)
Message-ID: <4713B2A1.4000503@pobox.com>
Date: Mon, 15 Oct 2007 14:34:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/5] Update ibm_newemac to use dcr_host_t.base
References: <33ee227bae85a8d7ccde69a717cff47000888354.1192440801.git.michael@ellerman.id.au>
In-Reply-To: <33ee227bae85a8d7ccde69a717cff47000888354.1192440801.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> Now that dcr_host_t contains the base address, we can use that in the
> ibm_newemac code, rather than storing it separately.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  drivers/net/ibm_newemac/mal.c |    9 +++++----
>  drivers/net/ibm_newemac/mal.h |    5 ++---
>  2 files changed, 7 insertions(+), 7 deletions(-)

applied 1-5
