From: tom_gall@vnet.ibm.com
Message-ID: <38D680B9.2D035E57@vnet.ibm.com>
Date: Mon, 20 Mar 2000 19:49:13 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Magic SysReq 
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

  Don't know if anyone has noticed or tried recently, but with the
2.2.14 kernel it would appear that the Magic Sys Request support for
kernel debug appears to be broke.
  (Granted I don't know that it ever worked as I haven't tried it on my
PPC box but none the less I just ran into this)

  Getta compile error on line 252 of drivers/char/keyboard.c

  Seems to need a ppc version. This might be because I'm making a kernel
for an RS6K. (I'm intending to make a device driver or two)

  Appreciate any insite. Thanks!

--
Hakuna Matata!                           |\      _,,,--,,_  ,)
Tom                                      /,`.-'`'   -,  ;-;;'
                                        |,4-  ) )-,_ ) /\
import standard.disclaimer.*;          '---''(_/--' (_/-'
Tom Gall - Linux Guy, LTC             "Where's the ka-boom? There was
IBM Rochester                          supposed to be an earth
(w) tom_gall@vnet.ibm.com              shattering ka-boom!"
(h) tgall@uswest.net                   -- Marvin Martian

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
