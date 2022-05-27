Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50564C433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 May 2022 00:23:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L8QWx1Sj4z3blX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 May 2022 10:23:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L8QWW1LWLz2xn8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2022 10:23:18 +1000 (AEST)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 24R0J1tq032490;
	Thu, 26 May 2022 19:19:02 -0500
Message-ID: <261e84b34ebbf5002ff47c31f8dc8c0e2f2a05f7.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drm/tiny: Add ofdrm for Open Firmware framebuffers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven
 <geert@linux-m68k.org>,
        Michal =?ISO-8859-1?Q?Such=E1nek?=
 <msuchanek@suse.de>
Date: Fri, 27 May 2022 10:19:01 +1000
In-Reply-To: <a077bc25-03b3-f8bd-0138-a175a2864943@suse.de>
References: <20220518183006.14548-1-tzimmermann@suse.de>
	 <20220518183006.14548-3-tzimmermann@suse.de>
	 <20220518185156.GJ163591@kunlun.suse.cz>
	 <CAMuHMdUws2eJ4pHng4GD0PjuvMj5Hef_y_YyM4fUJV9xdUVuEQ@mail.gmail.com>
	 <29a8201d-3c0c-eeed-81af-92b351880702@suse.de>
	 <615c93392bee43e92f0400cfa51957cd955091d3.camel@kernel.crashing.org>
	 <a077bc25-03b3-f8bd-0138-a175a2864943@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>, Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>, DRI Development <dri-devel@lists.freedesktop.org>, Paul Mackerras <paulus@samba.org>, Maxime Ripard <maxime@cerno.tech>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2022-05-25 at 18:45 +0200, Thomas Zimmermann wrote:
> I don't mind adding DRM support for BootX displays, but getting the 
> necessary test HW with a suitable Linux seems to be laborious. Would
> a  G4 Powerbook work?

Probably not unfortunately... it's going to be tricky. I might sitll
have some old BootX-based machines somewhere in storage I could try to
dig out, but it might not be worth bothering too much...

Cheers,
Ben.

