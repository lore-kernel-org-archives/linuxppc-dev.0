Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18437.18289.944128.351533@cargo.ozlabs.ibm.com>
Date: Wed, 16 Apr 2008 10:25:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v2.6.26 0/2] Dynamic TBIPA for gianfar
In-Reply-To: <1208276601-16964-1-git-send-email-paul.gortmaker@windriver.com>
References: <1208276601-16964-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Gortmaker writes:

> This is the resend of the two patches as per Andy's request for v2.6.26
> that allow boards with a PHY at the end of the bus to function, by having
> the TBIPA set dynamically.  The 1st patch factors out some of the PHY
> probe code so it can be recycled by the TBIPA probe, and the second patch
> implements the dynamic probe itself.

I notice that these two patches only touch drivers/net and
include/linux.  If you want these to go upstream into Linus' tree, you
will need to send them to Jeff Garzik and the netdev list.  Posting
them to the linuxppc-dev list is fine for getting them reviewed but
isn't a path to upstream.

Paul.
