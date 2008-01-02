Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6D8ACDDECB
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 04:39:30 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m02HfGTk016234
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jan 2008 12:41:16 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m02HdShW498198
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jan 2008 12:39:28 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m02HdSG3020189
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jan 2008 12:39:28 -0500
Date: Wed, 2 Jan 2008 11:37:52 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [POWERPC] Sequoia: typo in calling
	machine_device_initcall()
Message-ID: <20080102113752.2e53a1c7@zod.rchland.ibm.com>
In-Reply-To: <20080102172356.26645.63895.stgit@trillian.secretlab.ca>
References: <20080102172356.26645.63895.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 02 Jan 2008 10:23:56 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Oh, that's fun... my build scripts say this passed.  Looking at
powerpc.sequoia_defconfig.log.passed shows it obviously failed.  I hate
it when automated tools suck.

Thanks Grant.  Applied to my for-2.6.25 branch

josh

> ---
> 
>  arch/powerpc/platforms/44x/sequoia.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/44x/sequoia.c b/arch/powerpc/platforms/44x/sequoia.c
> index 374f8c7..d279db4 100644
> --- a/arch/powerpc/platforms/44x/sequoia.c
> +++ b/arch/powerpc/platforms/44x/sequoia.c
> @@ -38,7 +38,7 @@ static int __init sequoia_device_probe(void)
> 
>  	return 0;
>  }
> -machien_device_initcall(sequoia, sequoia_device_probe);
> +machine_device_initcall(sequoia, sequoia_device_probe);
> 
>  static int __init sequoia_probe(void)
>  {
> 
