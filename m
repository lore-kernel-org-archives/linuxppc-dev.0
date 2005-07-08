Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id C70DF67B7A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Jul 2005 18:24:01 +1000 (EST)
To: "Russell McGuire" <rmcguire@uwbt.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 07 Jul 2005 20:42:06 PDT."
	<20050707234210.GA24326@mail19d.g19.rapidsite.net>
Date: Fri, 08 Jul 2005 10:20:53 +0200
Sender: wd@denx.de
Message-Id: <20050708082053.C79E9353A62@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8280 Support for Linux 2.4.25 and up? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050707234210.GA24326@mail19d.g19.rapidsite.net> you wrote:
> 
> Are there any known issues with Linux 2.4.25 and supporting the MPC8280 CPU?

No.

> I have seen some posts in the past, and tried Google'ing for a patch for CPU
> support, but have only seen tidbits... Seen some support issues for the 5200
> as it also runs the G2_LE core.

We also support the MPC8220 in our source  tree  (U-Boot  and  Linux)
which is the same family.

> So I guess, I am asking if there are patches, perhaps where?

On our CVS server?

> Or should I consider moving up in kernel revisions, to get support for the
> newer CPM_2 drivers.

What for?


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A UNIX saleslady, Lenore,
Enjoys work, but she likes the beach more.
        She found a good way
        To combine work and play:
She sells C shells by the seashore.
