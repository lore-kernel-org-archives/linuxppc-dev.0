Return-Path: <jwilson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 29270DDEB9
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 07:21:18 +1100 (EST)
From: Jarod Wilson <jwilson@redhat.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 1/2] firewire: endianess fix
Date: Wed, 27 Feb 2008 15:21:04 -0500
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<200802271458.28401.jwilson@redhat.com>
	<47C5C340.7080302@s5r6.in-berlin.de>
In-Reply-To: <47C5C340.7080302@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802271521.05099.jwilson@redhat.com>
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, Sam Ravnborg <sam@ravnborg.org>,
	Harvey Harrison <harvey.harrison@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 27 February 2008 03:08:32 pm Stefan Richter wrote:
> Jarod Wilson wrote:
> > Works just fine with the Apple UniNorth controller in my powerbook in
> > cursory testing.
>
> Could you remove the OHCI1394_HCControl_postedWriteEnable flag from
> fw-ohci.c::ohci_enable() and test without and with the endianess patch?

Sure, added to the todo list along with making sure things survive bus resets.

-- 
Jarod Wilson
jwilson@redhat.com
