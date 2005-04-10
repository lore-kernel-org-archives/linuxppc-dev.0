Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 3E98E67B16
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 07:01:01 +1000 (EST)
Date: Sun, 10 Apr 2005 16:58:49 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Kylo Ginsberg <kylo@kylo.net>
In-Reply-To: <4259615E.2070608@kylo.net>
Message-ID: <Pine.LNX.4.61.0504101657530.8395@localhost.localdomain>
References: <Pine.LNX.4.61.0504101046030.8150@localhost.localdomain>
	<42594D18.4070403@kylo.net>
	<Pine.LNX.4.61.0504101302010.28010@localhost.localdomain>
	<4259615E.2070608@kylo.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-213083970-1113166729=:8395"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: how to get busybox shell prompt on console port?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-213083970-1113166729=:8395
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Sun, 10 Apr 2005, Kylo Ginsberg wrote:

> Fwiw, I explicitly created the CPM devices; note that the
> major/minor match those of your NULL nodes.  I'm running 2.6.11. 
> I'm fuzzy re if/how these devices should be automagically created by
> the kernel.
>
>  mknod ttyCPM0 c 204 46
>   mknod ttyCPM1 c 204 47
>   chmod 660 ttyCPM*
>
...
> crw-------    1 root     root     204,  46 Dec 31  1969 <NULL>0
> crw-------    1 root     root     204,  47 Dec 31  1969 <NULL>1

well, since i'm using devfs, i'm assuming that's what i get by
default.  ok, that clears up some of the confusion.  thanks.

rday
--8323328-213083970-1113166729=:8395--
