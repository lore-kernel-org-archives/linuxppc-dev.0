Return-Path: <shawnxjin@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id ADDB467B3D
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jun 2006 07:45:23 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id m51so921743pye
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jun 2006 14:45:21 -0700 (PDT)
Message-ID: <c3d0340b0606161445w5acb4da8j26870f56a4bf4d9@mail.gmail.com>
Date: Fri, 16 Jun 2006 14:45:21 -0700
From: "Shawn Jin" <shawnxjin@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: MSI support on Linux PCI implementation for Ocotea
In-Reply-To: <1150413771.7725.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <c3d0340b0606151414q6d218554j255fa74a68a5c9af@mail.gmail.com>
	<1150413771.7725.20.camel@localhost.localdomain>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

> Now, regarding MSI, as you have noticed, the situation isn't great. I'm
> currently in the middle of reworking our interrupt management (and
> interrupt numbers allocation layer) and Michael Ellermann is looking at
> the MSI issue in parallel.

Just one point about MSI(-X) message address and data format. I think
it should be the platform that defines the content. Current
implementation doesn't have this flexibility. We have a design where
MSI mode uses message data to carry vector number info while MSI-X
mode uses message address to carry this info. Although it seems
strange, but I think it's allowed by the spec.

Thanks,
-Shawn.
