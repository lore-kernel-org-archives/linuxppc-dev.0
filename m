Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.242])
	by ozlabs.org (Postfix) with ESMTP id 24219DE132
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 23:06:52 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so15702253agc.0
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 06:06:50 -0700 (PDT)
Message-ID: <fa686aa40807250606y670a8419p1e62fe66afe4cc3c@mail.gmail.com>
Date: Fri, 25 Jul 2008 09:06:41 -0400
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Luotao Fu" <l.fu@pengutronix.de>
Subject: Re: [spi-devel-general] [spi][mpc52xx][PATCH] Fix mpc52xx_psc_spi
	master driver
In-Reply-To: <20080725114341.GB6415@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080725114341.GB6415@pengutronix.de>
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 25, 2008 at 7:43 AM, Luotao Fu <l.fu@pengutronix.de> wrote:
> Hi,
>
> this is a fix for full duplex transfer mode on the mpc52xx_psc_spi driver.
> Details see the patch header. Tested on a mpc5200b board.
>
> Cheers
> Luotao fu

Looks pretty good to me.  I'll pick this up.

For future patches, please send patches inline and not as attachments.
 Attachments mess up the workflow because I cannot comment on the
patch by just hitting 'reply' and it doesn't work with git-am.

g.
-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
