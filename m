Message-ID: <20000430104734.12154.qmail@wwcst272.netaddress.usa.net>
Date: 30 Apr 00 05:47:34 CDT
From: jeramy b smith <ultrapenguin@netscape.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: cuda vs dmasound_awacs in 2.3.99
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


2.3.99 will allow me to not compile cuda support if I choose (my pbook uses
PMU). Unfortunately, dmasound_awacs.c makes cuda calls in the function
awacs_enable_amp. I tried doing an ifdef CONFIG_ADB_CUDA around this whole
function but this breaks the linking stage when that funtion is used of
course. I put an ifdef in the function after the function tests to see if
whether or not there is a cuda and this works ok for just getting 2.3.99 to
compile the way I want it to. Of course, I do not consider this the ideal way
to handle this.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
