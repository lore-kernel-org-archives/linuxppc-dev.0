Return-Path: <wd@denx.de>
Received: from mailout11.sul.t-online.com (mailout11.sul.t-online.com
	[194.25.134.85]) by ozlabs.org (Postfix) with ESMTP id 1C94767A06
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 09:27:58 +1000 (EST)
To: Kylo Ginsberg <kylo.ginsberg@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 16 May 2005 15:39:07 PDT."
	<61cc712d050516153941bc3b26@mail.gmail.com>
Date: Tue, 17 May 2005 01:27:39 +0200
Sender: wd@denx.de
Message-Id: <20050516232744.F106DC1512@atlas.denx.de>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC885 - USB HCI drivers. 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <61cc712d050516153941bc3b26@mail.gmail.com> you wrote:
>
> > My advice: use a _real_ USB controller.
> 
> Are there known problems with CPM-based USB controllers?  I'm

Ummmm... yes, there are. Especially if you want to use it as  a  host
comtroller  (which  is  never  was designed for). Even more, if there
might be other periopherals in your system that might need  a  bit  a
CPM performance. Or ...

No, I better stop here. Please ask your  Freecale  sales  representa-
tive. He may know better. [Or not, maybe.]

> completely new to the subject, but we are designing a board assuming
> we can use the USB controller on an MPC8555E.

You can do that. Anything can be done. But in this case I don't  know
of an efficient way to do it. But my knowledge is limited, obviously.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Man did not weave the web of life; he  is  merely  a  strand  in  it.
Whatever he does to the web, he does to himself.     - Seattle [1854]
