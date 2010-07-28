Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1280265853-21245-1-git-send-email-aalonso00@gmail.com>
References: <1280265853-21245-1-git-send-email-aalonso00@gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 28 Jul 2010 01:52:28 -0600
Message-ID: <AANLkTikHyoBtEzcPmsck9X_Xkg4iy7y+uU-59qm86-G+@mail.gmail.com>
Subject: Re: [PATCH] xilinxfb: update tft comp versions
To: Adrian Alonso <aalonso00@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 27, 2010 at 3:24 PM, Adrian Alonso <aalonso00@gmail.com> wrote:
> * Add tft display module compatibility for new
> =A0hardware modules
>
> Signed-off-by: Adrian Alonso <aalonso00@gmail.com>
> ---
> =A0drivers/video/xilinxfb.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
> index 574dc54..29b5daa 100644
> --- a/drivers/video/xilinxfb.c
> +++ b/drivers/video/xilinxfb.c
> @@ -485,6 +485,8 @@ static int __devexit xilinxfb_of_remove(struct of_dev=
ice *op)
> =A0/* Match table for of_platform binding */
> =A0static struct of_device_id xilinxfb_of_match[] __devinitdata =3D {
> =A0 =A0 =A0 =A0{ .compatible =3D "xlnx,xps-tft-1.00.a", },
> + =A0 =A0 =A0 { .compatible =3D "xlnx,xps-tft-2.00.a", },
> + =A0 =A0 =A0 { .compatible =3D "xlnx,xps-tft-2.01.a", },
> =A0 =A0 =A0 =A0{ .compatible =3D "xlnx,plb-tft-cntlr-ref-1.00.a", },
> =A0 =A0 =A0 =A0{ .compatible =3D "xlnx,plb-dvi-cntlr-ref-1.00.c", },
> =A0 =A0 =A0 =A0{},

I'll merged this, but it isn't exactly the best fix (not your fault; a
deficiency in the xilinx device tree generator).  I still need to get
around to fixing the generator to claim compatibility with the .00.a
ip core versions by default for newer parts with the same major
revision number.  Once it is fixed, then only the -2.00.a compatible
value would need to be added to the table.

Thanks Adrian.

g.
