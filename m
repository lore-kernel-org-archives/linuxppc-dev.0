Return-Path: <glikely@secretlab.ca>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.184])
	by ozlabs.org (Postfix) with ESMTP id 1A414DDF70
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Mar 2008 06:38:55 +1100 (EST)
Received: by gv-out-0910.google.com with SMTP id p33so17745gvf.14
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 06 Mar 2008 11:38:53 -0800 (PST)
Message-ID: <fa686aa40803061138s8ed3d6r53cff6324fdf99f2@mail.gmail.com>
Date: Thu, 6 Mar 2008 12:38:52 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Linn" <John.Linn@xilinx.com>
Subject: Re: Problems in fixup_device function
In-Reply-To: <20080306192149.4A0A9708064@mail119-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080306192149.4A0A9708064@mail119-dub.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Mar 6, 2008 at 12:21 PM, John Linn <John.Linn@xilinx.com> wrote:
>
>
>
>
> I've added some code to virtex_device_fixup and am seeing some strange side
> affects.  I've added code to read from an iic device and populate the mac
> address including ioremap.  The code works fine, but the side affects are
> not fine.

Specifically, what are you trying to do?  Are you modifying the data
in the platform device?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
