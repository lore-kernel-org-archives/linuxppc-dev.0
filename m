Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB94467B86
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 13:27:25 +1000 (EST)
Subject: Re: [PATCH] windfarm_smu_sat.c: simplify around i2c_add_driver()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
In-Reply-To: <20060821232223.GB5220@martell.zuzino.mipt.ru>
References: <20060821232223.GB5220@martell.zuzino.mipt.ru>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 13:27:03 +1000
Message-Id: <1156217223.21752.61.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-08-22 at 03:22 +0400, Alexey Dobriyan wrote:
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Oops ... :)

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
>  drivers/macintosh/windfarm_smu_sat.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> --- a/drivers/macintosh/windfarm_smu_sat.c
> +++ b/drivers/macintosh/windfarm_smu_sat.c
> @@ -397,12 +397,7 @@ static int wf_sat_detach(struct i2c_clie
>  
>  static int __init sat_sensors_init(void)
>  {
> -	int err;
> -
> -	err = i2c_add_driver(&wf_sat_driver);
> -	if (err < 0)
> -		return err;
> -	return 0;
> +	return i2c_add_driver(&wf_sat_driver);
>  }
>  
>  static void __exit sat_sensors_exit(void)
