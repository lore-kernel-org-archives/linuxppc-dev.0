Subject: Re: [PATCH] Permedia2 fb on PPC
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: mzyngier@freesurf.fr
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <wrpsnaq0xkx.fsf@hina.wild-wind.fr.eu.org>
References: <wrpsnaq0xkx.fsf@hina.wild-wind.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: 05 Dec 2001 18:19:40 +0100
Message-Id: <1007572780.21734.65.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2001-12-05 at 11:29, Marc ZYNGIER wrote:

> The following patchlet allows the Permedia2 framebuffer to work
> properly on power-pc (instead of crashing the machine...).

Why is this needed? And does it work with the XFree86 glint driver with
Option "UseFBDev"?


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
