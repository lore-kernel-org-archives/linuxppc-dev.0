Return-Path: <penberg@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.200])
	by ozlabs.org (Postfix) with ESMTP id 4694E679E2
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Feb 2006 22:06:46 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id x37so492850nfc
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Feb 2006 03:06:45 -0800 (PST)
Message-ID: <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
Date: Sun, 19 Feb 2006 13:06:45 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Sender: penberg@gmail.com
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: 2.6.16-rc4: known regressions
In-Reply-To: <20060217231444.GM4422@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
	<20060217231444.GM4422@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-acpi@vger.kernel.org, John Stultz <johnstul@us.ibm.com>,
	Meelis Roos <mroos@linux.ee>, gregkh@suse.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-input@atrey.karlin.mff.cuni.cz,
	Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/18/06, Adrian Bunk <bunk@stusta.de> wrote:
> Subject    : gnome-volume-manager broken on powerpc since 2.6.16-rc1
> References : http://bugzilla.kernel.org/show_bug.cgi?id=3D6021
> Submitter  : John Stultz <johnstul@us.ibm.com>
> Status     : still present in -git two days ago

This is not ppc only. I have the exact same problem on Gentoo
Linux/x86. No ipod events on 2.6.16-rc1, whereas 2.6.15 works fine.
Haven't had the time to investigate further yet, sorry.

                          Pekka
