Return-Path: <mike@it-loops.com>
Received: from lvps87-230-0-242.dedicated.hosteurope.de
	(lvps87-230-0-242.dedicated.hosteurope.de [87.230.0.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "plesk", Issuer "plesk" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1A7D3DDF77
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 20:49:46 +1100 (EST)
MIME-Version: 1.0
Date: Tue, 03 Mar 2009 10:49:35 +0100
From: Michael Guntsche <mike@it-loops.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: PHY not found after migration of gianfar driver to an
	=?UTF-8?Q?of=5Fplatform=5Fdriver?=
In-Reply-To: <9d38520266f15d80352d1554e63c1ce6@localhost>
References: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
	<fa686aa40902280703p5ad8ee73y116d7e2252df21a5@mail.gmail.com>
	<3B1D47A2-329E-491E-B3AC-E76C1CE1762D@it-loops.com>
	<fa686aa40903011353t464b1df3obd553132e5bc2570@mail.gmail.com>
	<CD026D29-687D-4078-960E-108CC94C30E4@it-loops.com>
	<fa686aa40903011715u2aed4c23tb8182634fa1220f6@mail.gmail.com>
	<c19541729a7d99548faadbabe5c7646c@localhost>
	<fa686aa40903020708y1f9f8ceeueb13f9146534df8d@mail.gmail.com>
	<9d38520266f15d80352d1554e63c1ce6@localhost>
Message-ID: <a57485706bfc7aae2295acd743445312@localhost>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 03 Mar 2009 08:35:02 +0100, Michael Guntsche <mike@it-loops.com>
wrote:
> As for adding additional information to the tree, can I also use libfdt
> functions in platform/83xx/rbppc.c or is it better to do this via a
> dedicated platform_init that simpleboot then uses?

Sorry, please forget this quesiton. Of course simpleboot only reads the
embedded tree 
so if I change the tree there it is the same as changing the initial DTS
file.
I will try to boot with a standard vmlinux image and then add the values in
rbppc.c.

Michael
