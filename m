Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id 32F4867C7F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jul 2005 04:45:09 +1000 (EST)
To: David Ho <davidkwho@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 19 Jul 2005 08:57:20 EDT."
	<4dd15d1805071905573ebcba61@mail.gmail.com>
Date: Tue, 19 Jul 2005 20:42:41 +0200
Sender: wd@denx.de
Message-Id: <20050719184241.78430352671@atlas.denx.de>
Cc: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
Subject: Re: How reliable is jffs2 really (denx cvs devel kernel)? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <4dd15d1805071905573ebcba61@mail.gmail.com> you wrote:
>
> I updated the JFFS2 portion of the Denx devel kernel with the latest
> from CVS and it solved the initial mount time problem.  But it was a
> while a ago when I did this.  Both the devel kernel and the CVS head
> has changed quite a bit since then.

I would rally appreciate if you mentioned which exact version of  the
kernel you are talking about. "The Denx devel kernel" can be anything
- either yesterday or 3 years old.

At the moment our CVS tree contains a snapshot from MTD CVS of  March
13, 2005; yes, we did the necessary backport to the 2.4 kernel.

Do you want to say that this version still  has  mount  time  issues?
Please provide details!


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The word "fit", as I understand it, means "appropriate to a purpose",
and I would say the body of the Dean is supremely appropriate to  the
purpose of sitting around all day and eating big heavy meals.
                                 - Terry Pratchett, _Moving Pictures_
