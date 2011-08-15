Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20110815150357.GM4926@sgi.com>
References: <1313138752-24006-1-git-send-email-holt@sgi.com>
	<1313138752-24006-4-git-send-email-holt@sgi.com>
	<20110815150357.GM4926@sgi.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 15 Aug 2011 09:13:50 -0600
Message-ID: <CACxGe6vafc6mYyKCAO+HqkRPsZ3GmeVJnK+z8=BX_wQQMG4LmQ@mail.gmail.com>
Subject: Re: [PATCH v12 3/6] flexcan: Fix up fsl-flexcan device tree binding.
To: Robin Holt <holt@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	U Bhaskar-B22300 <B22300@freescale.com>, socketcan-core@lists.berlios.de,
	Scott Wood <scottwood@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 15, 2011 at 9:03 AM, Robin Holt <holt@sgi.com> wrote:
> Grant,
>
> Earlier, you had asked for a more specific name for the compatible
> property of the Freescale flexcan device. =A0I still have not gotten a
> more specific answer. =A0Hopefully Marc can give you more details about
> the flexcan implementations.

If there is no ip core version, then just stick with the
fsl,<soc>-flexcan name and drop "fsl,flexcan".  Marketing may say
flexcan is flexcan, but hardware engineers like to change things.
Trying to be too generic in compatible values will just lead to
problems in the future.

g.
