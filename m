Message-ID: <40CA2BBF.4090800@icarus.com>
Date: Fri, 11 Jun 2004 15:01:35 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: "Tom Rini trini-at-kernel.crashing.org |PPC Linux Embedded|" <xvpqhxpoxp0t@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Head of linuxppc-2.4 broekn by davem patch
References: <1086934906.4820.2.camel@lucy.pep-kaufbeuren.de> <29963-82182@sneakemail.com> <20040611214054.GB925@smtp.west.cox.net>
In-Reply-To: <20040611214054.GB925@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini trini-at-kernel.crashing.org |PPC Linux Embedded| wrote:
> On Fri, Jun 11, 2004 at 09:07:13AM -0700, Stephen Williams wrote:
>
>
>>Stefan Nickl Stefan.Nickl-at-kontron.com |PPC Linux Embedded| wrote:
>>
>>>I already sent this patch to the list and to "davem" who
>>>commited the faulty version, but nobody seems to care...
>>
>>Here is the exact same patch, packaged slightly differently
>>and re-sent, just in case it got lost in someone's inbox.
>>It is also possible that davem is thinking in terms of
>>changing the sk_buff definition t match this file. Either
>>way, something must be done.
>
>
> I've gotten around to updating the linuxppc-2.4 repository to match the
> current state of linux-2.4 again.  If there's still a problem, I would
> suggest reproducing it with an i386 config (or CONFIG_ALL_PPC config)
> and posting to lkml (linux-kernel@vger.kernel.org) and cc'ing Marcelo
> and whomever made the broken change.


It appears that davem already supplied the fix in change set 1.1058.421.35.
That was May 30 or thereabouts. Thanks.

Now to see what nagging can get the ibm405gpr.h header file fixed...

--
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
