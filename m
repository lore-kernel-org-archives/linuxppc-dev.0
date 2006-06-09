Return-Path: <anton@ozlabs.org>
Date: Fri, 9 Jun 2006 21:56:08 +1000
From: Anton Blanchard <anton@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] convert powermac ide blink to new led infrastructure
Message-ID: <20060609115608.GE23891@krispykreme>
References: <1149635136.32002.49.camel@johannes>
	<1149726524.23790.5.camel@localhost.localdomain>
	<1149853629.3864.9.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1149853629.3864.9.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The way it usually works is via sysfs. Automatic at boot could be
> default by assigning a default name somewhere IIRC, but since I don't
> use the LED I optimised for that case ;)
> I'd say having a script that *enables* it at boot is probably cleaner
> than having one that *disables* it, and having a Kconfig option just for
> the default seems overkill.

On the other hand, Ive come to expect it on my laptop :)

Anton
