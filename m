Return-Path: <delobelle@blueyonder.co.uk>
Received: from smtp-out1.blueyonder.co.uk (smtp-out1.blueyonder.co.uk
	[195.188.213.4]) by ozlabs.org (Postfix) with ESMTP id AC36167B2A
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 12:02:47 +1000 (EST)
Message-ID: <425733B8.1040906@blueyonder.co.uk>
Date: Sat, 09 Apr 2005 02:45:28 +0100
From: Arnaud Delobelle <delobelle@blueyonder.co.uk>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1113006674.9568.414.camel@gaston>
In-Reply-To: <1113006674.9568.414.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Benjamin Herrenschmidt wrote:
> Hi !
> 
> If you have a newer machine, that is a machine released on or after
> 2002, can you please send me the output of:
> 
> echo `cat /proc/device-tree/model`

PowerBook5,2

> for i in `find /proc/device-tree -name layout-id -print`; do echo $i && hexdump -n4 $i; done

Nothing

-- 
Arnaud
