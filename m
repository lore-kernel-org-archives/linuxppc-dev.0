In-Reply-To: <E380A44D523BD5118EAE0002A52CE5C40B9A0601@zcard0k8.ca.nortel.com>
References: <E380A44D523BD5118EAE0002A52CE5C40B9A0601@zcard0k8.ca.nortel.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1D730B0C-9CCF-11D8-BFF6-000A95B15278@aimsys.nl>
Cc: "linuxppc-embedded@lists.linuxppc" <linuxppc-embedded@lists.linuxppc.org>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Subject: Re: Spurious Interrupts.. 2.4.22 82xx platforms
Date: Mon, 3 May 2004 08:57:17 +0200
To: "Andrew Williams" <awilliam@nortelnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Andrew,

Are you aware of this?
http://lists.linuxppc.org/linuxppc-embedded/200211/msg00139.html

I'm not sure of this is your problem though

Jaap-Jan

On May 2, 2004, at 17:02, Andrew Williams wrote:

>
> Trying to wrap my mind around where my "spurrious" interrupts
> are coming from.
>
> I've used some debug code to determine where the spurrious
> counter was being incremented, in an attempt to see the
> what/how/why. All occurences are a result of m8260_get_irq()
> returning -1 (empty SIVEC register).
>
> Ideas or pointers as to what might be occuring here?
> We're using an 8270.
>
> Can anyone reference a paper/chat/email that details the nature
> of the SIVEC/SPINRx solution in linux?
>
>
> Thanks
> Andrew
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
