Message-ID: <4109B225.8020604@mvista.com>
Date: Thu, 29 Jul 2004 21:27:49 -0500
From: Corey Minyard <cminyard@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	Kumar Gala <kumar.gala@motorola.com>
Subject: Re: Patch for debug setcontext
References: <41090F9A.8000901@mvista.com> <BA214A7E-E195-11D8-8E6C-000393DBC2E8@freescale.com>
In-Reply-To: <BA214A7E-E195-11D8-8E6C-000393DBC2E8@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm using stock 2.6.7.  Is there a different kernel I should be using?

-Corey

Kumar Gala wrote:

>
> On Jul 29, 2004, at 9:54 AM, Corey Minyard wrote:
>
>> Kumar Gala wrote:
>>
>> > I'm guessing, this should really be #if defined(CONFIG_4xx) ||
>> > defined(CONFIG_BOOKE)
>> > There are a number of similar cases later in this code as well.
>>
>> That may be the case, but it is very confusing in entry.S.  The dbcr0
>> register seems to only be defined on 4xx processor, not on book E.
>> Look, for instance, at load_4xx_dbcr0:, it is only defined if 4xx is
>> enabled, not if book E is enabled.
>
>
> Corey,
>
> I think you may have an old linux-2.6 tree.  I remember renaming
> load_4xx_dbcr0 to just load_dbcr0 because of such issues.  Hopefully a
> newer tree (one with e500 support, if its going head_e500.S) should be
> cleaner.  If not, let me know.
>
> - kumar
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
