To: "Williams, Kevin M." <kevin.m.williams@marconi.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Abatron BDI2000 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 Nov 2001 11:36:40 EST."
             <A3E34B558F5CD211B4980008C7A4A99003C5853A@sparrow.gso.mcs.marconi.com>
Date: Tue, 20 Nov 2001 18:13:15 +0100
Message-Id: <20011120171320.8601DF9B9@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Kevin,

in message <A3E34B558F5CD211B4980008C7A4A99003C5853A@sparrow.gso.mcs.marconi.com> you wrote:
>
> I just received a BDI2000 and it works great for debugging my bootrom, but
> I'm a little confused about settings to use for debugging the
> kernel...seeing a working example should be enough to get me going.

Oops??? The config file for the  BDI2000  depends  on  the  processor
architecture  and  board  used,  but  that's it. You can use the SAME
config file both for firmware and for Linux kernel debugging.

Make sure you've RTFM about the "MMU XLAT" and the "PTBASE" settings.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Computers are not intelligent.  They only think they are.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
