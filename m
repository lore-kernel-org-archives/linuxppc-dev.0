Return-Path: <jwboyer@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 66635B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jul 2011 21:24:25 +1000 (EST)
Received: by vws20 with SMTP id 20so4612021vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jul 2011 04:24:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110713154405.297f828d@kryten>
References: <20110713154405.297f828d@kryten>
Date: Wed, 13 Jul 2011 07:24:21 -0400
Message-ID: <CA+5PVA7cGL+f94T3VL4NRvMSLD4L5mWn=iYAPujqYcH9aHhOVQ@mail.gmail.com>
Subject: Re: [PATCH] hvc_console: Add kdb support
From: Josh Boyer <jwboyer@gmail.com>
To: Anton Blanchard <anton@samba.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kgdb-bugreport@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
	jason.wessel@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2011 at 1:44 AM, Anton Blanchard <anton@samba.org> wrote:
>
> Add poll_get_char and poll_put_char for kdb. Enable kdb at boot with:

Did you mean "...for kgdb.  Enable kgdb at boot.." ?

I thought kdb and kgdb shared some infrastructure now, but your patch
and comments seem to be all about kgdb.

josh
