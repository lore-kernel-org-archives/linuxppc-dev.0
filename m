Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: drivers - modules versus compiled in?
Date: Wed, 31 Oct 2001 16:18:04 -0500
MIME-Version: 1.0
Message-Id: <20011031211539.SIZF7882.tomts5-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

What is differnt between the cases a driver is compiled in versus if it is
loaded as a module?

I seem to be having stability issues with the driver if it is compiled in
but once I compile it as a module to start to play with it without having
to reboot all of the time, the driver is does not exhibit the same bad
behavior.

Are the allocated memory areas differnt?  Are the IRQs different?  is the
power-up sequence different?

Any hints as to what might have changed?

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
