Return-Path: <scottwood@freescale.com>
Date: Tue, 23 Oct 2007 14:12:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Device trees and audio codecs
Message-ID: <20071023191236.GB4825@loki.buserror.net>
References: <9e4733910710200833x5d1c55b5l2cd400f77c13ec87@mail.gmail.com>
	<471B550F.3090907@freescale.com>
	<9e4733910710210701x67b2e99frd0784ac2c8bd27fd@mail.gmail.com>
	<471CA082.1050304@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <471CA082.1050304@freescale.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 22, 2007 at 08:07:14AM -0500, Timur Tabi wrote:
> Either you do it at driver __init time, or via a probe.  The probe 
> actually occurs at __init time, anyway, so they're kinda the same thing. 
>   The only thing the probe gets you is that you're called multiple times 
> for each instance of a node in the tree.

It also means that you're *not* called if there's no node in the tree at all
-- which I believe was Jon's point about being platform specific.

-Scott
