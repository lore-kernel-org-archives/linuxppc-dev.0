Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 61DB52C0090
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2012 23:35:51 +1100 (EST)
Message-ID: <1352204902.3346.1.camel@thor.local>
Subject: Re: [PATCH] powermac/cpufreq_32: set non-infinite transition time
 for 7447A driver
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Tue, 06 Nov 2012 13:28:22 +0100
In-Reply-To: <m24nld1vx9.fsf@igel.home>
References: <m24nld1vx9.fsf@igel.home>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-10-29 at 10:15 +0100, Andreas Schwab wrote:=20
> The transition time for the 7447A is around 8ms which makes it possible
> to use the ondemand governor.  This has been tested on the iBook G4
> (PowerBook6,7).
>=20
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Tested-by: Michel D=E4nzer <michel@daenzer.net>


--=20
Earthling Michel D=E4nzer           |                   http://www.amd.com
Libre software enthusiast         |          Debian, X and DRI developer
