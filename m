Return-Path: <josh@joshtriplett.org>
Received: from slow1-d.mail.gandi.net (slow1-d.mail.gandi.net [217.70.178.86])
 by ozlabs.org (Postfix) with ESMTP id 003922C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 22:25:59 +1100 (EST)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 by slow1-d.mail.gandi.net (Postfix) with ESMTP id 8E08247B012
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 12:11:33 +0100 (CET)
Date: Mon, 16 Dec 2013 03:11:13 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: Rashika Kheria <rashika.kheria@gmail.com>
Subject: Re: [PATCH 2/2] drivers: tty: Mark the function hvc_poll_init() as
 static in hvc_console.c
Message-ID: <20131216111113.GB23211@leaf>
References: <0d40902c95942d272a70b1d85b4e311d0cc7afa4.1387191158.git.rashika.kheria@gmail.com>
 <0dc41f5b30bf9b5c94e658387ffaf092736c26b2.1387191158.git.rashika.kheria@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <0dc41f5b30bf9b5c94e658387ffaf092736c26b2.1387191158.git.rashika.kheria@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Slaby <jslaby@suse.cz>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 16, 2013 at 04:31:28PM +0530, Rashika Kheria wrote:
> Mark the function hvc_poll_init() as static in hvc/hvc_console.c becaus=
e
> it is not used outside this file.
>=20
> This eliminates the following warning in hvc/hvc_console.c:
> drivers/tty/hvc/hvc_console.c:791:5: warning: no previous prototype for=
 =E2=80=98hvc_poll_init=E2=80=99 [-Wmissing-prototypes]
>=20
> Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  drivers/tty/hvc/hvc_console.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_consol=
e.c
> index 9eba119..50b4688 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -788,7 +788,7 @@ static int hvc_tiocmset(struct tty_struct *tty,
>  }
> =20
>  #ifdef CONFIG_CONSOLE_POLL
> -int hvc_poll_init(struct tty_driver *driver, int line, char *options)
> +static int hvc_poll_init(struct tty_driver *driver, int line, char *op=
tions)
>  {
>  	return 0;
>  }
> --=20
> 1.7.9.5
>=20
