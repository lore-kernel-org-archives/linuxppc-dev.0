Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 01AC72C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Aug 2013 08:15:35 +1000 (EST)
Message-ID: <1376777376.25016.11.camel@pasglop>
Subject: Re: [RFC PATCH v2 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Date: Sun, 18 Aug 2013 08:09:36 +1000
In-Reply-To: <2032060.4bgTKOdEX2@flatron>
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <2032060.4bgTKOdEX2@flatron>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jonas Bonn <jonas@southpole.se>, devicetree@vger.kernel.org,
 Michal Simek <monstr@monstr.eu>, linux-pm@vger.kernel.org,
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

On Sat, 2013-08-17 at 12:50 +0200, Tomasz Figa wrote:
> I wonder how would this handle uniprocessor ARM (pre-v7) cores, for
> which 
> the updated bindings[1] define #address-cells = <0> and so no reg 
> property.
> 
> [1] - http://thread.gmane.org/gmane.linux.ports.arm.kernel/260795

Why did you do that in the binding ? That sounds like looking to create
problems ... 

Traditionally, UP setups just used "0" as the "reg" property on other
architectures, why do differently ?

Ben.
