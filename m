Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84913B7BC5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Oct 2009 02:59:03 +1100 (EST)
Date: Tue, 6 Oct 2009 11:07:49 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: SMU-base PowerMac and server_mode
Message-ID: <20091006160749.GA29195@lixom.net>
References: <8028e5750910060216x134a8a9cm461fa5a6e87eb6bb@mail.gmail.com>
	<1254823882.6035.5.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1254823882.6035.5.camel@pasglop>
Cc: Romain Goyet <r.goyet@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 06, 2009 at 09:11:22PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2009-10-06 at 11:16 +0200, Romain Goyet wrote:
> > Hi there,
> > 
> > 
> >   I have this Quad G5 here, running GentooPPC64. Runs fine. Had a hard
> > time getting it to boot without a screen attached, but I eventually
> > managed to (yaboot was the culprit). However, this machine is
> > SMU-based, and I couldn't find a way to enable the equivalent of the
> > PMU's "server_mode" (i.e. automatically reboot after a power failure).
> > Is there any known way to do that ?
> 
> I'm pretty sure I reverse engineered the necessary command a while back
> and somebody wrote a userland tool to set it, but I can't find it
> anymore :-)

Yeah, I had one but I have since lost it.  I suspect it was on the
drive of my second quad that I wiped before I sold it, thinking there
was nothing of value on it. :(


-Olof
