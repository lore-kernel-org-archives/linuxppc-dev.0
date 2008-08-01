Return-Path: <ben@trinity.fluff.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.145.97.151])
	by ozlabs.org (Postfix) with ESMTP id 527C5DDF04
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 20:44:04 +1000 (EST)
Date: Fri, 1 Aug 2008 11:43:47 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: libata badness
Message-ID: <20080801104347.GM26938@trinity.fluff.org>
References: <95646AC3-5385-4F59-8EBA-20F811168A87@kernel.crashing.org>
	<20080731210410.GA623@polina.dev.rtsoft.ru>
	<DAE7C7B4-CE5B-45EB-B3B4-E5491A843CD9@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DAE7C7B4-CE5B-45EB-B3B4-E5491A843CD9@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 04:58:05PM -0500, Kumar Gala wrote:
> I figured out the issue.  Its related to the interrupt routing being  
> conveyed to the code from the device tree.  We have a missing 'space'  
> causing issues.

out of interest, is the M5229 attached to a single IRQ in this device
or has the bridge been configured to route the IRQs from the IDE to
the same pin on the PIC?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
