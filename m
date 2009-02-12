Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 48035DDDAA
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 08:18:43 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so478809yxb.39
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 13:18:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ccb913ac0902100507x69113827m757f3b8fbd0ac6f4@mail.gmail.com>
References: <ccb913ac0902100507x69113827m757f3b8fbd0ac6f4@mail.gmail.com>
Date: Thu, 12 Feb 2009 14:18:41 -0700
Message-ID: <fa686aa40902121318i65ec44edtf119a6ad2d4d1570@mail.gmail.com>
Subject: Re: writel hangs system
From: Grant Likely <grant.likely@secretlab.ca>
To: Tobias Knutsson <tobias.knutsson@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 10, 2009 at 6:07 AM, Tobias Knutsson
<tobias.knutsson@gmail.com> wrote:
> Hello,
>
> I'm in the process of porting a PCI-driver for a dsp-board from 2.4 to
> 2.6. The probing of the driver goes well, IRQs are setup, resources
> are claimed and remapped without any problems. Reading from I/O
> regions also works well. However, when i try to read or write to a
> memory region using readl/writel, the system instantly hangs. No
> stacktrace or anything, it just stops.

Hmmm.  Not good.  Are you able to access the memory regions from the
U-Boot console?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
