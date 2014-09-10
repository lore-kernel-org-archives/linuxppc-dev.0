Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (s3.sipsolutions.net [5.9.151.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C48591A003D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 00:31:16 +1000 (EST)
Message-ID: <1410357424.2761.5.camel@jlt4.sipsolutions.net>
Subject: Re: [PATCH] sound: aoa: printk replacement
From: Johannes Berg <johannes@sipsolutions.net>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 10 Sep 2014 15:57:04 +0200
In-Reply-To: <1410357107-29933-1-git-send-email-sudipm.mukherjee@gmail.com>
 (sfid-20140910_155200_822543_7A3FBE01)
References: <1410357107-29933-1-git-send-email-sudipm.mukherjee@gmail.com>
 (sfid-20140910_155200_822543_7A3FBE01)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-09-10 at 19:21 +0530, Sudip Mukherjee wrote:
> as pr_* macros are more preffered over printk, so printk replaced
> with corresponding pr_* macros.

Are you simply running checkpatch on every file and decided to do
something about it? :)

I'll let Takashi decide whether to take this or not as I no longer care
about this code, but IMHO this changes is completely pointless since you
don't also clean up the code to have a common prefix with #define pr_fmt
and then clean up the callers etc.

There's a reason pr_* is preferred, but random code changes like this
aren't it, I think.

johannes
