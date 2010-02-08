Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 4D568B7D1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Feb 2010 22:21:38 +1100 (EST)
Date: Mon, 8 Feb 2010 12:21:16 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Paride Legovini <pl@ninthfloor.org>
Subject: Re: resurrecting the mvme5100 ppc platform
Message-ID: <20100208112116.GA3381@iram.es>
References: <20100204133935.GA9337@ninthfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100204133935.GA9337@ninthfloor.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 04, 2010 at 01:39:35PM +0000, Paride Legovini wrote:
> Hello,
> I'm just started working on some mvme5100 boards, and so I discovered
> that support for these cards has been dropped with linux-2.6.27 due to
> lack of interest. Here is the relevent post on linuxppc-embedded:
> 
> http://www.mail-archive.com/linuxppc-embedded@ozlabs.org/msg30049.html
> 
> Well, I'd really like to see support for the mvme5100 to be reintegrated
> in the kernel. I'm willing to help on this, but at the moment I don't
> know how much work is to be done, as I don't know how the switch from
> ppc to powerpc changed things.

A lot, these are PreP platforms. I'm using several MVME24xx/26xx/27xx
here (some have been running continously over a decade). They have 
a lot of similarities with MVME5100 if I remember correctly. 

I don't have time right now (especially if I am alone) to write 
support for them, but I am interested in running a more recent
kernel, provided it's not too bloated (some machines only have
16MB of RAM).

	Regards,
	Gabriel
