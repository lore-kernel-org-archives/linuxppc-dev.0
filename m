Return-Path: <neko@genesi-usa.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 58617DDD1B
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 07:05:11 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so388344yxb.39
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 12:05:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090220191108.GA21163@ovro.caltech.edu>
References: <b5e2fc790902201057of113946yea9ccc7405e31926@mail.gmail.com>
	<20090220191108.GA21163@ovro.caltech.edu>
Date: Fri, 20 Feb 2009 14:05:08 -0600
Message-ID: <b5e2fc790902201205t4bd03373w7e7624fce60f5eb0@mail.gmail.com>
Subject: Re: PCI reading without endian conversion
From: Matt Sealey <matt@genesi-usa.com>
To: Ira Snyder <iws@ovro.caltech.edu>
Content-Type: text/plain; charset=UTF-8
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 20, 2009 at 1:11 PM, Ira Snyder <iws@ovro.caltech.edu> wrote:
> On Fri, Feb 20, 2009 at 12:57:36PM -0600, Matt Sealey wrote:
>
> I'm pretty sure memcpy_fromio() and memcpy_toio() will get you what you
> want. They don't change byte ordering.

Are they guaranteed to only do 32-bit, aligned accesses?

I made some cheats on my CPLD to ignore byte enables and so on,
because it makes the design cleaner and easier to read (for students)
plus, saves a ton of logic cells. It's totally within the PCI
standard, but it means if you do a byte read memcpy() you get.. very
weird results (i.e. not great).

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
