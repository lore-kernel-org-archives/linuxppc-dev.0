Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0DF1B70A9
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Nov 2010 09:32:16 +1100 (EST)
Subject: Re: [PATCH v3] add icswx support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <28760.1288650181@neuling.org>
References: <1287547340.14049.25.camel@flin.austin.ibm.com>
	<28760.1288650181@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Nov 2010 09:31:58 +1100
Message-ID: <1288650718.2147.20.camel@pasglop>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com, linuxppc-dev@ozlabs.org,
	"Tseng-Hui \(Frank\) Lin" <thlin@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-11-02 at 09:23 +1100, Michael Neuling wrote:
> +EXPORT_SYMBOL(switch_cop);
> +EXPORT_SYMBOL(use_cop);
> +EXPORT_SYMBOL(drop_cop);
> 
> Please document how to use these. 

Also, should these be _GPL ?

Cheers,
Ben.
