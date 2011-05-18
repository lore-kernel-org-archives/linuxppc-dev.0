Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2AE9AB6F59
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:48:27 +1000 (EST)
Subject: Re: powerpc: mpc85xx regression since 2.6.39-rc2, one cpu core lame
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <1305739191_6593@mail4.comsite.net>
References: <20110517162827.GA16918@riccoc20.at.omicron.at>
	<1305668416.2781.23.camel@pasglo>
	<20110518120320.GA3025@riccoc20.at.omicron.at>
	<1305739191_6593@mail4.comsite.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 07:48:10 +1000
Message-ID: <1305755290.7481.7.camel@pasglop>
Mime-Version: 1.0
Cc: Kerstin Jonsson <kerstin.jonsson@ericsson.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-05-18 at 12:19 -0500, Milton Miller wrote:
> Does this patch help?  If so please reply to that thread so patchwork
> will see it in addition to here.
> 
> http://patchwork.ozlabs.org/patch/96146/

Interesting. I'll have a closer look today. Unfortunately, I don't have
any 32-bit BookE SMP at hand at the moment so I couldn't test those
configs.

Cheers,
Ben.
