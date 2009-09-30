Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6423FB7BCB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Oct 2009 06:31:03 +1000 (EST)
Subject: Re: 64bit kernel is huge
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <5642.1254290487@neuling.org>
References: <20090928074503.GB16073@kryten>  <5642.1254290487@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 01 Oct 2009 06:30:55 +1000
Message-Id: <1254342655.5699.9.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-30 at 16:01 +1000, Michael Neuling wrote:
> 2.6.30     9221595      1620728 1052812 11895135        b5815f
> 2.6.29     9104807      1569840  785292 11459939        aedd63 

The jump in BSS size is huge...  lockdep ?

Ben.
