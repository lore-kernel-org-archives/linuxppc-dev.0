Return-Path: <krypton@ulrich-teichert.org>
Received: from arbas.nms.ulrich-teichert.org (i3ED64D51.versanet.de
	[62.214.77.81]) by ozlabs.org (Postfix) with ESMTP id 5942A2BF12
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2005 09:13:19 +1100 (EST)
Message-Id: <200501052209.j05M9xAs009904@arbas.nms.ulrich-teichert.org>
To: krypton@ulrich-teichert.org (Ulrich Teichert)
Date: Wed, 5 Jan 2005 23:09:58 +0100 (MET)
In-Reply-To: <200501050807.j0587L5J026680@arbas.nms.ulrich-teichert.org> from
	"Ulrich Teichert" at Jan 05, 2005 09:07:20 AM
From: Ulrich Teichert <krypton@ulrich-teichert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, mikemartin@linux.ca,
	debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

the only reference number on my board is the IBM FRU number:

FRU 93H7143

I would expect that you will have the same marking on your mainboard.
My box ran all day with various loads from high to low or no load
at all:

wehrle:~> uptime
 22:29:24 up 1 day,  2:39,  2 users,  load average: 0.15, 0.32, 0.61

with Leigh's 2.4.19 kernel. As I searched for the number, I noticed
that the CPU fan was *covered* with dirt. Perhaps you should have
a look at yours too, because the front fan will pick up all dust and
throw it right on the CPU fan. I still wonder why mine was still
spinning....

HTH,
Uli
-- 
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
Stormweg 24               |listening to: Suicide Drive (The Deep Eynde)
24539 Neumuenster, Germany|Public Pervert (Interpol) Clé De Contact (Metal Urbain)
