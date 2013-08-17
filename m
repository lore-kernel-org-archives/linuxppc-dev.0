Return-Path: <tomasz.figa@gmail.com>
Received: from mail-bk0-x22e.google.com (mail-bk0-x22e.google.com
 [IPv6:2a00:1450:4008:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1DBB02C012C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Aug 2013 08:22:53 +1000 (EST)
Received: by mail-bk0-f46.google.com with SMTP id 6so994864bkj.19
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2013 15:22:48 -0700 (PDT)
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
Date: Sun, 18 Aug 2013 00:22:43 +0200
Message-ID: <6043373.ZgY5Yo1tNM@flatron>
In-Reply-To: <1376777376.25016.11.camel@pasglop>
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <2032060.4bgTKOdEX2@flatron> <1376777376.25016.11.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jonas Bonn <jonas@southpole.se>, devicetree@vger.kernel.org,
 Michal Simek <monstr@monstr.eu>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 linux-pm@vger.kernel.org,
 Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 18 of August 2013 08:09:36 Benjamin Herrenschmidt wrote:
> On Sat, 2013-08-17 at 12:50 +0200, Tomasz Figa wrote:
> > I wonder how would this handle uniprocessor ARM (pre-v7) cores, for
> > which
> > the updated bindings[1] define #address-cells = <0> and so no reg
> > property.
> > 
> > [1] - http://thread.gmane.org/gmane.linux.ports.arm.kernel/260795
> 
> Why did you do that in the binding ? That sounds like looking to create
> problems ...

[Copying Lorenzo...]

I'm not the author of the change. I was just passing by, while the 
question showed up in my mind. ;)

> Traditionally, UP setups just used "0" as the "reg" property on other
> architectures, why do differently ?

Right, especially since the ARM DT topology parsing code still considers a 
device tree without reg property in cpu node invalid.

Best regards,
Tomasz
