Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 390191A026E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Dec 2015 07:55:06 +1100 (AEDT)
Date: Wed, 30 Dec 2015 14:12:59 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Curt Brune <curt@cumulusnetworks.com>
Cc: galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com,
 pawel.moll@arm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, robh+dt@kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 1/1] powerpc: legacy serial port use device tree cell-index
 property
Message-ID: <20151230201259.GA11741@gate.crashing.org>
References: <1448477209-22340-2-git-send-email-curt@cumulusnetworks.com>
 <20151220150225.GA27380@gate.crashing.org>
 <20151230163601.GX14046@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151230163601.GX14046@cumulusnetworks.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 30, 2015 at 08:36:01AM -0800, Curt Brune wrote:
> > What does this do if the value in cell-index is a duplicate. or the port
> > with that number is already created some other way?  Are the numbers in
> > cell-index global anyway, or relative to some parent device (I couldn't
> > find the documentation for this).
> 
> add_legacy_port() has support for handling duplicate index entries.
> Reading that code it looks like the recent entry wins and the older
> entry is moved to the next available index.
> 
> The numbers in cell-index are not global nor explicitly relative to a
> parent device.  I also could not find documentation on this.

That sounds like it should work then.  It does change behaviour for
existing configs.

Thanks,


Segher
