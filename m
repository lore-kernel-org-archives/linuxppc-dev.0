Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.227])
	by ozlabs.org (Postfix) with ESMTP id 63C46DDF9F
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 01:34:17 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so2898499nzh
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 08:34:15 -0700 (PDT)
Message-ID: <fa686aa40710020834o74f70639w9b108cb85c4452f0@mail.gmail.com>
Date: Tue, 2 Oct 2007 09:34:14 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: [PATCH 08/18] Uartlite: Add macro for uartlite device name
In-Reply-To: <87ejgd356y.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181726.18608.73695.stgit@trillian.cg.shawcable.net>
	<87ejgd356y.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/2/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
>
> Hi,
>
>  Grant> From: Grant Likely <grant.likely@secretlab.ca>
>  Grant> Changed to make the OF bus binding a wee bit cleaner
>
>  Grant> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>  Grant> ---
>
>  Grant>  arch/powerpc/platforms/40x/Kconfig |    4 ++--
>  Grant>  drivers/serial/uartlite.c          |    5 +++--
>  Grant>  2 files changed, 5 insertions(+), 4 deletions(-)
>
>  Grant> diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
>  Grant> index 1aae0e6..44f08dd 100644
>  Grant> --- a/arch/powerpc/platforms/40x/Kconfig
>  Grant> +++ b/arch/powerpc/platforms/40x/Kconfig
>  Grant> @@ -65,8 +65,8 @@ config XILINX_VIRTEX_GENERIC_BOARD
>  Grant>         bool "Generic Xilinx Virtex board"
>  Grant>         depends on 40x
>  Grant>         default y
>  Grant> -       select VIRTEX_II_PRO
>  Grant> -       select VIRTEX_4_FX
>  Grant> +       select XILINX_VIRTEX_II_PRO
>  Grant> +       select XILINX_VIRTEX_4_FX
>
> Huh? What does this have to do with $SUBJ?

This was a mess up on my part on this version of the patch set.  v3
has it fixed.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
