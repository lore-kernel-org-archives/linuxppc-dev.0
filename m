To: "Jeff H. Zhong" <jeff@doremilabs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for ppc440GX with GIG-ethernet 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 17 Oct 2003 17:44:13 PDT."
             <3F908CDD.6CD53D1F@doremilabs.com>
Date: Sat, 18 Oct 2003 23:10:55 +0200
Message-Id: <20031018211100.BBEFFC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3F908CDD.6CD53D1F@doremilabs.com> you wrote:
>
> Do you know the status of support for IBM PPC440GX with gig-ethernet
> interface? Both from ELDK root fs, tool chain and LinuxPPC kernel?

The ELDK root filesystem (= native tools) and  tool  chain  (=  cross
tools  and native tools) have zero relation to available drivers in a
specific kernel tree.

[I don't knowmuch about the current state of gigabit ethernet support
for the 440GX.]

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If a train station is a place where a train stops,
                                           then what's a workstation?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
