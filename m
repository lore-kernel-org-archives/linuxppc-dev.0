To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BAT mapping exported to user-space
References: <E86979D8-DF6A-11D8-9BE7-003065F9B7DC@embeddededge.com>
From: "Linh Dang" <linh@linhdang.home>
Date: Mon, 26 Jul 2004 22:27:25 -0400
In-Reply-To: <E86979D8-DF6A-11D8-9BE7-003065F9B7DC@embeddededge.com> (Dan
 Malek's message of "Mon, 26 Jul 2004 21:18:46 -0400")
Message-ID: <wn5zn5mqj5e.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@embeddededge.com> wrote:
>
> On Jul 26, 2004, at 2:33 PM, Linh Dang wrote:
>
>> My understanding is:
>>
>> - mmap(2) uses pages to map the device (my platform doesn't have large
>> page.)
>
> Yes, so?
>
>> - mapping a large address range (hundreds-of-megabytes) is much more
>> efficient with BATs than with pages.
>
> Depends upon your measurement of efficiency.
>
>> So, do you mean:
>> - mmap(2) can use BATs? or
>
> Not likely due to alignment and size constraints.
>
>> - the difference in performance is negligible between BATs and
>> pages when mapping an address range of 200MBs?
>
> If you can measure or are affected by the difference, there are many
> more things that will ensure your software will not work properly.

What do you mean by the above sentence?

- 200MB would need 51200 ptes. that means doubling the current number
  of ptes on my system.

- If using block mapping doesn't help that much then why would X make
  all the effort to grab MTRRs on X86?

- why would the kernel use BATs to map its memory?

--
Linh Dang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
