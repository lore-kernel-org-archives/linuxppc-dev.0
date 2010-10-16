Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id 2FA9FB70E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Oct 2010 14:52:30 +1100 (EST)
Received: by pwj2 with SMTP id 2so531242pwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 20:52:29 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Fri, 15 Oct 2010 21:52:26 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] powerpc/5121: pdm360ng: fix touch irq if 8xxx gpio
	driver is enabled
Message-ID: <20101016035226.GE21170@angua.secretlab.ca>
References: <1284581577-2217-1-git-send-email-agust@denx.de>
	<20101014165549.473d71ab@wker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101014165549.473d71ab@wker>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 14, 2010 at 04:55:49PM +0200, Anatolij Gustschin wrote:
> Hi Grant,
> 
> On Wed, 15 Sep 2010 22:12:57 +0200
> Anatolij Gustschin <agust@denx.de> wrote:
> 
> > Enabling the MPC8xxx GPIO driver with MPC512x GPIO extension
> > breaks touch screen support on this board since the GPIO
> > interrupt will be mapped to 8xxx GPIO irq host resulting in
> > a not requestable interrupt in the touch screen driver. Fix
> > it by mapping the touch interrupt on 8xxx GPIO irq host.
> > 
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> > ---
> >  arch/powerpc/platforms/512x/pdm360ng.c |   26 ++++++++++++++++++++++----
> >  1 files changed, 22 insertions(+), 4 deletions(-)
> 
> Can this patch go in for 2.6.37 ?

I hope so, but I haven't looked at it properly yet and I'm trying to
dig myself out of a patch backlog.

g.
