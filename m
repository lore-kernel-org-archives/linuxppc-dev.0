In-Reply-To: <41090F9A.8000901@mvista.com>
References: <41090F9A.8000901@mvista.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BA214A7E-E195-11D8-8E6C-000393DBC2E8@freescale.com>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Kumar Gala <kumar.gala@motorola.com>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: Patch for debug setcontext
Date: Thu, 29 Jul 2004 14:30:19 -0500
To: Corey Minyard <cminyard@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Jul 29, 2004, at 9:54 AM, Corey Minyard wrote:

> Kumar Gala wrote:
>
> > I'm guessing, this should really be #if defined(CONFIG_4xx) ||
> > defined(CONFIG_BOOKE)
> > There are a number of similar cases later in this code as well.
>
> That may be the case, but it is very confusing in entry.S.  The dbcr0
> register seems to only be defined on 4xx processor, not on book E.
> Look, for instance, at load_4xx_dbcr0:, it is only defined if 4xx is
> enabled, not if book E is enabled.

Corey,

I think you may have an old linux-2.6 tree.  I remember renaming
load_4xx_dbcr0 to just load_dbcr0 because of such issues.  Hopefully a
newer tree (one with e500 support, if its going head_e500.S) should be
cleaner.  If not, let me know.

- kumar


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
