Return-Path: <anton@samba.org>
Date: Sun, 30 Jan 2011 09:22:17 +1100
From: Anton Blanchard <anton@samba.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: 2.6.37-git17 virtual IO boot failure
Message-ID: <20110130092217.70ebb424@kryten>
In-Reply-To: <20110119043757.GA29865@us.ibm.com>
References: <20110118123152.50f75a72@kryten>
	<20110118224718.GA19039@us.ibm.com>
	<1295409980.2148.125.camel@pasglop>
	<20110119043757.GA29865@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: jlarrew@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> FWIW, I looked at Anton's logs, and I don't think the boot failed, per
> se. I think it may have timed out (but not positive on that). I was
> able to boot 2.6.27-git17 on the exact same box, albeit it locks up
> at a later point (the sd abort I e-mailed about in a follow-up).

This fail bisects down to the VPHN (shared processor affinity) patch.
I've got some fixes on the way.

Anton
