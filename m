Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8EE8B70D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 09:33:25 +1100 (EST)
Date: Tue, 12 Oct 2010 00:33:08 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] [PATCH] allow low HZ values?
In-Reply-To: <1286836212.5220.19.camel@pasglop>
Message-ID: <alpine.LFD.2.00.1010120032060.2909@localhost6.localdomain6>
References: <20101011201121.GA953@tpepper-t61p.dolavim.us>
	<1286836212.5220.19.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marcio Saito <marcio@cyclades.com>, Jiri Slaby <jirislaby@gmail.com>,
	John Stultz <johnstul@us.ibm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Tim Pepper <lnxninja@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Avantika Mathur <mathur@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 12 Oct 2010, Benjamin Herrenschmidt wrote:

> On Mon, 2010-10-11 at 13:11 -0700, Tim Pepper wrote:
> > I'm not necessarily wanting to open up the age old question of "what is
> > a good HZ", but we were doing some testing on timer tick overheads for
> > HPC applications and this came up...
> 
> Note that this is also very useful when working on CPU prototypes
> implemented in FPGAs and running at something like 12Mhz :-)

/me hands benh 0.5$ for a FPGA upgrade
