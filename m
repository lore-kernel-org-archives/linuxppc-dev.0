Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 0B0A2DF774
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 08:52:33 +1000 (EST)
Received: by gxk14 with SMTP id 14so789134gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 15:52:32 -0700 (PDT)
Message-ID: <fa686aa40808211552x4ff22c4bve2b8c9dbc88ff0e4@mail.gmail.com>
Date: Thu, 21 Aug 2008 16:52:32 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH 3/3]: of: Add some I2C mod aliases table entries for
	sparc64 systems.
In-Reply-To: <20080821.001025.76289480.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080821.001025.76289480.davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	devicetree-discuss@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 21, 2008 at 1:10 AM, David Miller <davem@davemloft.net> wrote:
>
> of: Add some I2C mod aliases table entries for sparc64 systems.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>

I'd like to see a comment above these three lines stating that they
appear in Sparc systems, but otherwise...

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.

> ---
>  drivers/of/base.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index ad8ac1a..e849f69 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -410,7 +410,9 @@ struct of_modalias_table {
>        char *modalias;
>  };
>  static struct of_modalias_table of_modalias_table[] = {
> -       /* Empty for now; add entries as needed */
> +       { "i2c-adm1031", "adm1031" },
> +       { "i2c-at24c64", "24c64" },
> +       { "i2c-at34c02", "spd" },
>  };
>
>  /**
> --
> 1.5.6.5.GIT
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
