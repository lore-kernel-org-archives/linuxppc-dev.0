Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 189FEB7B60
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Aug 2009 02:09:42 +1000 (EST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <9e4733910908210823g1743ec7ei8bc80536afc7864f@mail.gmail.com>
References: <9e4733910908210823g1743ec7ei8bc80536afc7864f@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 21 Aug 2009 10:09:19 -0600
Message-ID: <fa686aa40908210909u6252c730nfd59e87c3d881df@mail.gmail.com>
Subject: Re: mpc5200, reboots will idle
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 21, 2009 at 9:23 AM, Jon Smirl<jonsmirl@gmail.com> wrote:
> I've been getting unexplained reboots. This one printed a dump. Does
> it make sense to anyone?
> The system was just sitting idle at a command prompt.

No, I've not seen anything like that, and I don't see anything
interesting in the back trace.  Data corruption in a device driver
perhaps?

I'll keep my eyes open if I see anything similar.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
