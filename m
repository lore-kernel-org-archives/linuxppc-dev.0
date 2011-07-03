Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
	[195.113.26.193]) by ozlabs.org (Postfix) with ESMTP id 1E8D3B6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Jul 2011 03:26:00 +1000 (EST)
Date: Sun, 3 Jul 2011 19:16:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 3/7] fault-injection: notifier error injection
Message-ID: <20110703171626.GG21127@elf.ucw.cz>
References: <1309702581-16863-1-git-send-email-akinobu.mita@gmail.com>
	<1309702581-16863-4-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309702581-16863-4-git-send-email-akinobu.mita@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-mm@kvack.org,
	Paul Mackerras <paulus@samba.org>, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, linux-pm@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> +	for (action = enb->actions; action->name; action++) {
> +		struct dentry *file = debugfs_create_int(action->name, mode,
> +						enb->dir, &action->error);
> +
> +		if (!file) {
> +			debugfs_remove_recursive(enb->dir);
> +			return -ENOMEM;
> +		}

Few lines how this work would be welcome...?
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
