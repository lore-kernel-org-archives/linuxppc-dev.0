Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 06D82DDE02
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 10:39:18 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/3][POWERPC][V2] of_serial: Fix possible null dereference.
Date: Thu, 3 Apr 2008 01:39:04 +0200
References: <20080402165216.8FD2BC9807F@mail21-dub.bigfish.com>
	<fa686aa40804021046n1bc0626ay6a3f9f2a251331ef@mail.gmail.com>
In-Reply-To: <fa686aa40804021046n1bc0626ay6a3f9f2a251331ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804030139.05497.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 02 April 2008, Grant Likely wrote:
> On Wed, Apr 2, 2008 at 10:52 AM, John Linn <john.linn@xilinx.com> wrote:
> > From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> >
> > =A0The of_serial driver queries the current-speed property and attempts
> > =A0to use it to register the custom_divisor property of the uart_port.
> > =A0However, if current-speed is not set, then this code will dereference
> > =A0a bad pointer. =A0The fix is to only set custom_divisor when a
> > =A0current-speed property appears in the device tree.
> >
> > =A0Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> > =A0Signed-off-by: John Linn <john.linn@xilinx.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Arnd Bergmann <arnd@arndb.de>
