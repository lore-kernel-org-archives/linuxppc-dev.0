Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EE6F82C0096
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2012 17:26:34 +1000 (EST)
In-Reply-To: <alpine.LNX.2.00.1209212355050.8539@linmac>
References: <alpine.LNX.2.00.1209212355050.8539@linmac>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <50EE7AAC-3080-4B1B-B741-E3F7F5A57A73@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Probing for native availability of isel from userspace
Date: Sat, 22 Sep 2012 09:26:12 +0200
To: malc <av1474@comtv.ru>
Cc: linuxppc-dev@lists.ozlabs.org, hollis@penguinppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Is it possible to determine if _native_ isel is available from  
> userspace
> somehow?

Just try to execute one and catch the SIGILL?


Segher
