Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f178.google.com (mail-yw0-f178.google.com
	[209.85.211.178]) by ozlabs.org (Postfix) with ESMTP id 23195B7BE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 17:14:07 +1100 (EST)
Received: by ywh8 with SMTP id 8so602694ywh.3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 22:14:05 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912081339.50722.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Dec 2009 23:13:45 -0700
Message-ID: <fa686aa40912102213m5b2a0092i3c25d73b914ece93@mail.gmail.com>
Subject: Re: [PATCH] PowerPC: const intspec pointers
To: Roman Fietze <roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 8, 2009 at 5:39 AM, Roman Fietze <roman.fietze@telemotive.de> wrote:
> Hello,
>
> Writing a driver using SCLPC on the MPC5200B I detected, that the
> intspec arrays to map irqs to Linux virq cannot be const, because the
> mapping and xlate functions only take non const pointers. All those
> functions do not modify the intspec, so a const pointer could be used.

BTW, if you're interested, there is a driver for the SCLPC FIFO about
to be merged into 2.6.33.  It's in Ben's tree waiting to be pulled
into mainline.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
