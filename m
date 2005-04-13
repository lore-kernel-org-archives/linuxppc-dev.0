Return-Path: <eddy.petrisor@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.203])
	by ozlabs.org (Postfix) with ESMTP id 37E2167B6B
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Apr 2005 08:38:08 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so241656wri
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2005 15:38:07 -0700 (PDT)
Message-ID: <425D988D.4000807@gmail.com>
Date: Thu, 14 Apr 2005 01:09:17 +0300
From: Eddy Petrisor <eddy.petrisor@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1113006674.9568.414.camel@gaston>
In-Reply-To: <1113006674.9568.414.camel@gaston>
Content-Type: text/plain; charset=x-user-defined; format=flowed
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

> 
> and
> 
> for i in `find /proc/device-tree -name layout-id -print`; do echo $i && hexdump -n4 $i; done
> 

Nothing

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
I am not sure if my Powerbook was released after 2002, but the date(the 
copyright stuff) on the back is 2003.

-- 
Regards,
EddyP
===========================
I had a favourite quote, but I forgot it. And it was insightful.
