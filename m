In-Reply-To: <wn5ekmysjns.fsf@linhd-2.ca.nortel.com>
References: <EB9CAD60-DF2E-11D8-910D-003065F9B7DC@embeddededge.com> <wn5ekmysjns.fsf@linhd-2.ca.nortel.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E86979D8-DF6A-11D8-9BE7-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: BAT mapping exported to user-space
Date: Mon, 26 Jul 2004 21:18:46 -0400
To: Linh Dang <linh@linhdang.home>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 26, 2004, at 2:33 PM, Linh Dang wrote:

> My understanding is:
>
> - mmap(2) uses pages to map the device (my platform doesn't have large
> page.)

Yes, so?

> - mapping a large address range (hundreds-of-megabytes) is much more
>   efficient with BATs than with pages.

Depends upon your measurement of efficiency.

> So, do you mean:
>         - mmap(2) can use BATs? or

Not likely due to alignment and size constraints.

>         - the difference in performance is negligible between BATs and
>           pages when mapping an address range of 200MBs?

If you can measure or are affected by the difference, there are many
more things that will ensure your software will not work properly.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
