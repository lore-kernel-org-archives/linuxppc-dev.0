Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A137A67DCF
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 00:21:57 +1000 (EST)
Date: Thu, 5 Oct 2006 09:21:15 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Enable DEEPNAP power savings mode on 970MP
Message-ID: <20061005092115.6948663f@localhost.localdomain>
In-Reply-To: <1160026464.22232.16.camel@localhost.localdomain>
References: <20061004234141.749b13fb@localhost.localdomain>
	<1160026464.22232.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 05 Oct 2006 15:34:24 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Isn't deep nap supposed to only get entered from F/4 which we never
> use ?
> 
> Ben confused...

Nope.

The User Manual clearly talks about going in/out of deep nap from the
different powertune frequencies, see for example section 6.4.2 and 9.4.2.


-Olof
