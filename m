Message-Id: <199910211928.VAA20201@denx.local.net>
To: linuxppc-dev@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.de>
Subject: Probing for (non-existing) memory?
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Thu, 21 Oct 1999 21:28:01 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

please excuse the silly question: is there a standard way to probe an
address if it is readable/writable memory? Ideally something that  is
portable across all architectures?

[For those familiar with LynxOS: what I'm looking  for  is  something
like recoset() / noreco().]

Thanks in advance,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Never give in.  Never give in.  Never. Never. Never."
- Winston Churchill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
