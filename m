Message-ID: <41090F9A.8000901@mvista.com>
Date: Thu, 29 Jul 2004 09:54:18 -0500
From: Corey Minyard <cminyard@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org,
	Kumar Gala <kumar.gala@freescale.com>
Subject: Re: Patch for debug setcontext
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kumar Gala wrote:

 > I'm guessing, this should really be #if defined(CONFIG_4xx) ||
 > defined(CONFIG_BOOKE)
 > There are a number of similar cases later in this code as well.

That may be the case, but it is very confusing in entry.S.  The dbcr0
register seems to only be defined on 4xx processor, not on book E.
Look, for instance, at load_4xx_dbcr0:, it is only defined if 4xx is
enabled, not if book E is enabled.

-Corey


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
