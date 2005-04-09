Return-Path: <523958@unizar.es>
Received: from relay.unizar.es (relay.unizar.es [155.210.11.72])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 47AC967B25
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 22:11:02 +1000 (EST)
Message-ID: <4257BD37.2040008@unizar.es>
Date: Sat, 09 Apr 2005 13:32:07 +0200
From: Pablo Guerrero <523958@unizar.es>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1113006674.9568.414.camel@gaston>
In-Reply-To: <1113006674.9568.414.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Sound drivers for newer machines: need help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Benjamin Herrenschmidt wrote:
> Hi !
> 
> If you have a newer machine, that is a machine released on or after
> 2002, can you please send me the output of:
> 
> echo `cat /proc/device-tree/model`
> 

PowerBook6,5

> and
> 
> for i in `find /proc/device-tree -name layout-id -print`; do echo $i && hexdump -n4 $i; done
> 

Nothing.

> If the later returns nothing, it's fine, just tell me.
> 
> I'm especially interested in the various models of G5 based machines. It
> seems apple is having all sorts of very different sound HW setups on
> those machines, and I'm trying to figure out exactly what is where based
> on those infos and the darwin sources.
> 
> Ben.
> 
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCV702bc/QOFfiAIYRAqlmAJ0aZT3nARj1XNYDt8JRe7UBBkgqqACfR45q
gMVXd9LzdnYLNZKWpDOKQdg=
=1oHh
-----END PGP SIGNATURE-----
