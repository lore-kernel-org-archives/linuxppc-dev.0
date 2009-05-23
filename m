Return-Path: <jonsmirl@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 90FFFDE106
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 09:20:33 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1383306qwe.15
	for <linuxppc-dev@ozlabs.org>; Sat, 23 May 2009 16:20:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090523231148.17919.46103.stgit@terra>
References: <20090523231148.17919.46103.stgit@terra>
Date: Sat, 23 May 2009 19:20:31 -0400
Message-ID: <9e4733910905231620m29510186mc983c9c4e568f4bb@mail.gmail.com>
Subject: Re: [PATCH V2 0/9] mpc5200 audio rework for AC97
From: Jon Smirl <jonsmirl@gmail.com>
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, broonie@sirena.org.uk
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 23, 2009 at 7:12 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> The following series implements audio support for the mpc5200. It adds an AC97 driver and STAC9766 codec driver. Board support for the Efika and Phytec pcm030 are also included.

Series is based on branch for-2.6.31 commit
0154724d487586241c1ad57cfd348ed2ff2274e2  at
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

-- 
Jon Smirl
jonsmirl@gmail.com
