To: Toni Van Remortel <t.vanremortel@ha.be>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IBM PPC 405GP kernel compile problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 28 Mar 2003 09:35:48 +0100."
             <20030328093548.0597f71f.t.vanremortel@ha.be>
Date: Fri, 28 Mar 2003 11:03:12 +0100
Message-Id: <20030328100317.E789BC6E0D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030328093548.0597f71f.t.vanremortel@ha.be> you wrote:
>
> I'm using the cross-compiler from denx.de for PPC_4xx, and I patched a 2.4.15 kernel with the appropriate PPC-patch.

Where did you get this 2.4.15 kernel from?

For 4xx you should use the linuxppc_2_4_devel tree. Using this  tree,
we  have  no  problems  to  compile  and run Linux on a couple of 4xx
systems using the ELDK.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Don't put off for tomorrow what you can  do  today,  because  if  you
enjoy it today you can do it again tomorrow.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
