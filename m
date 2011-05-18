Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08F691007D8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:49:06 +1000 (EST)
Subject: Re: powerpc: mpc85xx regression since 2.6.39-rc2, one cpu core lame
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Richard Cochran <richardcochran@gmail.com>
In-Reply-To: <20110518120320.GA3025@riccoc20.at.omicron.at>
References: <20110517162827.GA16918@riccoc20.at.omicron.at>
	<1305668416.2781.23.camel@pasglop>
	<20110518120320.GA3025@riccoc20.at.omicron.at>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 07:48:58 +1000
Message-ID: <1305755338.7481.8.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> (I get the feeling that I am the only one testing recent kernels with
> the mpc85xx.)
> 
> Anyhow, I see that this commit was one of a series. For my own use,
> can I simply revert this one commit independently?

For your own use sure :-) But I'd still like to get to the bottom of
this !

Cheers,
Ben.
