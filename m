To: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to pass "-Wa,e500" to gcc when building a bootstrap compiler ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 28 Jan 2004 19:44:02 CST."
             <0B0A39652BB0D411BCCF00508B9512EC0E5962B3@tx14exm05.ftw.mot.com>
Date: Thu, 29 Jan 2004 09:02:32 +0100
Message-Id: <20040129080237.69A67C115D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <0B0A39652BB0D411BCCF00508B9512EC0E5962B3@tx14exm05.ftw.mot.com> you wrote:
>
> Is there any trick to make gcc have a default option like '-Wa,e500' ?

Edit .../usr/lib/gcc-lib/ppc-linux/X.Y.Z/specs


Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Harrisberger's Fourth Law of the Lab:
	Experience is directly proportional to the
	amount of equipment ruined.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
