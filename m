Return-Path: <menoz@ngi.it>
Received: from vsmtp12.tin.it (vsmtp12.tin.it [212.216.176.206])
	by ozlabs.org (Postfix) with ESMTP id 4A30067B20
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 20:26:47 +1000 (EST)
Date: Sat, 9 Apr 2005 12:21:16 +0200
From: Daniele Menozzi <menoz@ngi.it>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050409102115.GA1379@shine.homelinux.org>
References: <1113006674.9568.414.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1113006674.9568.414.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Sound drivers for newer machines: need help
Reply-To: menoz@ngi.it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On  10:31:14 09/Apr , Benjamin Herrenschmidt wrote:
> echo `cat /proc/device-tree/model`

PowerBook4,3

> for i in `find /proc/device-tree -name layout-id -print`; do echo $i && hexdump -n4 $i; done

nothing

> Ben.
 
 Thank you
 	Menoz

-- 
		      Free Software Enthusiast
		 Debian Powered Linux User #332564 
		     http://shine.homelinux.org
