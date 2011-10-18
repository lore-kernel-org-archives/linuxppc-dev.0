Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.179.29])
 by ozlabs.org (Postfix) with ESMTP id 1E570B6F8A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 20:51:04 +1100 (EST)
Date: Tue, 18 Oct 2011 04:43:28 -0500
From: Robin Holt <holt@sgi.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v13 0/6] flexcan: Add support for powerpc flexcan
 (freescale p1010)
Message-ID: <20111018094328.GC22814@sgi.com>
References: <1313551944-28603-1-git-send-email-holt@sgi.com>
 <16FBAA47-5133-43A1-80CE-C6D63B79FB5D@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <16FBAA47-5133-43A1-80CE-C6D63B79FB5D@kernel.crashing.org>
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
 socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
 PPC list <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 18, 2011 at 12:44:07AM -0500, Kumar Gala wrote:
> 
> On Aug 16, 2011, at 10:32 PM, Robin Holt wrote:
> 
> > David,
> > 
> > The following set of patches have been reviewed by the above parties and
> > all comments have been integrated.  Although the patches stray from the
> > drivers/net/can directory, the diversions are related to changes for
> > the flexcan driver.
> > 
> > The patch set is based upon your net-next-2.6 tree's commit 6c37e46.
> > 
> > Could you please queue these up for the next appropriate push to Linus'
> > tree?
> > 
> > Thanks,
> > Robin Holt
> 
> Robin,
> 
> Do you remember why we went with just 'fsl,p1010-flexcan' as the device tree compatible?  Do we feel the flex can on P1010 isn't the same as on MPC5xxx? or the ARM SoCs?

The decision was due to the fact there is no true "generic" fsl.flexcan
chip free of any SOC implementation and therefore not something which
could be separately defined.  That decision was made by Grant Likely.
I will inline that email below.

Robin


On Mon, Aug 15, 2011 at 09:13:50AM -0600, Grant Likely wrote:
> On Mon, Aug 15, 2011 at 9:03 AM, Robin Holt <holt@sgi.com> wrote:
> > Grant,
> >
> > Earlier, you had asked for a more specific name for the compatible
> > property of the Freescale flexcan device.  I still have not gotten a
> > more specific answer.  Hopefully Marc can give you more details about
> > the flexcan implementations.
> 
> If there is no ip core version, then just stick with the
> fsl,<soc>-flexcan name and drop "fsl,flexcan".  Marketing may say
> flexcan is flexcan, but hardware engineers like to change things.
> Trying to be too generic in compatible values will just lead to
> problems in the future.

Thanks,
Robin
