Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B441BB7BD9
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2009 14:15:40 +1100 (EST)
Subject: Re: [PATCH 3/6 v5] Memory probe/release files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4AE8AFDD.6030504@austin.ibm.com>
References: <4AE8ADCF.6090104@austin.ibm.com> <4AE8AFDD.6030504@austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Oct 2009 14:13:33 +1100
Message-ID: <1256786013.26770.40.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-10-28 at 15:55 -0500, Nathan Fontenot wrote:
> This patch creates the release sysfs file for memory and updates the
> exisiting probe file so both make arch-specific callouts to handle removing
> and adding memory to the system.  This also creates the powerpc specific stubs
> for handling the arch callouts.
> 
> The creation and use of these files are governed by the exisitng
> CONFIG_ARCH_MEMORY_PROBE and new CONFIG_ARCH_MEMORY_RELEASE config options.
> 
> Signed-off-by: Nathan Fontenot <nfont at austin.ibm.com>
> ---

Is there anybody on linux-mm who needs to Ack this patche ?

Cheers,
Ben.
