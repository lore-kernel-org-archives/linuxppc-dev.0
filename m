Subject: Re: Error in drm with 2.6.7-rc2
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Cedric Pradalier <cedric.pradalier@inrialpes.fr>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20040605133935.1e560a09.cedric.pradalier@inrialpes.fr>
References: <20040605133935.1e560a09.cedric.pradalier@inrialpes.fr>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jun 2004 23:21:07 +0200
Message-Id: <1086643267.2331.35.camel@localhost>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-06-05 at 13:39 +0200, Cedric Pradalier wrote:
>
> Jun  5 13:30:04 ceruse kernel: [drm] Initialized radeon 1.10.0 20020828 on minor 0: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]
> Jun  5 13:30:10 ceruse kernel: [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> Jun  5 13:30:10 ceruse kernel: [drm:radeon_unlock] *ERROR* Process 1387 using kernel context 0

These are harmless symptoms of not dealing gracefully with the failure
to initialize the DRM.

> (WW) RADEON(0): [agp] AGP not available

This has been discussed last week on linux-kernel and dri-devel, see
http://marc.theaimsgroup.com/?l=linux-kernel&m=108639488301600&w=2 .


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
