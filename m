Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CE803B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 02:41:37 +1000 (EST)
In-Reply-To: <20120605120222.6722a3e3@kryten>
References: <20120604175858.38dac554@kryten> <20120605120222.6722a3e3@kryten>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <178E3BC0-C6E2-4E33-BA66-8144F192A151@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Optimise the 64bit optimised __clear_user
Date: Wed, 6 Jun 2012 18:40:54 +0200
To: Anton Blanchard <anton@samba.org>
Cc: mikey@neuling.org, michael@ellerman.id.au, paulus@samba.org, olof@lixom.net,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +err1;	dcbz	r0,r3

There is no such instruction, you probably meant "dcbz 0,r3"?


Segher
