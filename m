Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CA0822C012F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 14:55:26 +1000 (EST)
Message-ID: <1376628601.4255.138.camel@pasglop>
Subject: Re: [RFC PATCH 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Date: Fri, 16 Aug 2013 14:50:01 +1000
In-Reply-To: <1376586580-5409-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jonas Bonn <jonas@southpole.se>, devicetree@vger.kernel.org,
 Michal Simek <monstr@monstr.eu>, linux-pm@vger.kernel.org,
 microblaze-uclinux@itee.uq.edu.au, linux@openrisc.net,
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

On Thu, 2013-08-15 at 18:09 +0100, Sudeep KarkadaNagesha wrote:
>                /* Check for ibm,ppc-interrupt-server#s. If it doesn't exist
>                  * fallback to "reg" property and assume no threads
>                  */
> -

Oh and I forgot ... that comment is now wrong, since your code handles
threads in the "reg" case...

Cheers,
Ben.
