Return-Path: <tpapp@tpapp.student.princeton.edu>
Received: from Princeton.EDU (postoffice01.Princeton.EDU [128.112.129.75])
	by ozlabs.org (Postfix) with ESMTP id 2872F67B6C
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 11:30:19 +1000 (EST)
Date: Fri, 8 Apr 2005 21:20:56 -0400
From: Tamas K Papp <tpapp@Princeton.EDU>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050409012056.GA6727@tpapp.student.princeton.edu>
References: <1113006674.9568.414.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1113006674.9568.414.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Sound drivers for newer machines: need help
Reply-To: tpapp@Princeton.EDU
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 09, 2005 at 10:31:14AM +1000, Benjamin Herrenschmidt wrote:
> Hi !
> 
> If you have a newer machine, that is a machine released on or after
> 2002, can you please send me the output of:
> 
> echo `cat /proc/device-tree/model`
> 
> and
> 
> for i in `find /proc/device-tree -name layout-id -print`; do echo $i && hexdump -n4 $i; done
> 
> If the later returns nothing, it's fine, just tell me.

% echo `cat /proc/device-tree/model`
PowerBook5,4
% for i in `find /proc/device-tree -name layout-id -print`; do echo $i && hexdump -n4 $i; done
/proc/device-tree/pci@f2000000/mac-io@17/i2s@10000/i2s-a@10000/sound/layout-id
0000000 0000 0033
0000004


Best,

Tamas
