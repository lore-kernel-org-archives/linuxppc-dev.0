In-Reply-To: <wn58yd5p7og.fsf@linhd-2.ca.nortel.com>
References: <10A74DE9-DFF7-11D8-96F8-003065F9B7DC@embeddededge.com> <wn58yd5p7og.fsf@linhd-2.ca.nortel.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DAD37954-E008-11D8-96F8-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: BAT mapping exported to user-space
Date: Tue, 27 Jul 2004 16:09:24 -0400
To: "Linh Dang" <linh@linhdang.home>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 27, 2004, at 3:32 PM, Linh Dang wrote:

> Thanx for pointing that out. I have to dig further. I guess it would
> come down to how much pressure using pages for mapping our asics
> (instead of BATs) would have on the TLBs.

As I pointed out in one of the very first messages, you can write
a custom device driver to implement various mapping schemes
based upon your requirements.  However, this could result in
something not portable to another kernel version.

> Just to clarify things, I'm trying to sell Linux to management (we're
> a VxWorks shop) and trying to tell them that Linux's
> RT-performance/efficiency is adequate and Linux would bring in a lot
> more robustness/stability.

I've been involved in too many of this discussions to realize this
is never an engineering trade off.  Linux can do this VxWorks can't,
VxWorks can do things Linux can't, and there is a whole bunch
of computing where they do equally well.   The discussion we've
had is irrelevant to the choice.  Find some features worthy of
discussion and use them to make the decision. You can solve
any OS challenge with Linux, you just have to find the people
with the knowledge and be willing to do it.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
