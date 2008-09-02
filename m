Return-Path: <scottwood@freescale.com>
Date: Tue, 2 Sep 2008 18:43:40 -0500
From: Scott Wood <scottwood@freescale.com>
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: DTS question
Message-ID: <20080902234340.GA19055@ld0162-tx32.am.freescale.net>
References: <48BDB68E.8040806@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48BDB68E.8040806@mlbassoc.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 02, 2008 at 03:56:30PM -0600, Gary Thomas wrote:
> What gives?  Why is explicit hex sometimes an error and sometimes not?
> Is the format of this file documented anywhere (I've not found it)?

If the file has /dts-v1/; at the top, it uses version 1 of the device
tree syntax, which has C-like numerical constants.  Without it, you get
version zero syntax, with implicit hex.

-Scott
