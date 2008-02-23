Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 927FFDDEDF
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 22:36:50 +1100 (EST)
Date: Sat, 23 Feb 2008 12:36:33 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 1/2] firewire: endianess fix
To: linux1394-devel@lists.sourceforge.net
In-Reply-To: <tkrat.9e19fa31951506af@s5r6.in-berlin.de>
Message-ID: <tkrat.e867721c03e156c2@s5r6.in-berlin.de>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<1203545913.25307.47.camel@brick>
	<tkrat.e2bfb30f2c0ae70a@s5r6.in-berlin.de>
	<tkrat.9e19fa31951506af@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Jarod Wilson <jwilson@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
	Harvey Harrison <harvey.harrison@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wrote:
> If possible, also test whether the device remains accessible after
> forcing a bus reset, e.g. by "echo br short > firecontrol".

"echo br short | firecontrol" of course.

This test should actually not really be necessary because simply
plugging the SBP-2 device in should already cause enough generation
changes for the code to trip over an endianess bug before or after thhe
patch, me thinks.
-- 
Stefan Richter
-=====-==--- --=- =-===
http://arcgraph.de/sr/
