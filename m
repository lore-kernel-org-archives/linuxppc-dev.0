From: Matthias Grimm <matthias.grimm@htp-tel.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Any known problems with usleep() in 2.6.7?
Date: Fri, 16 Jul 2004 20:56:10 +0200
References: <200407132134.58687.matthias.grimm@htp-tel.de>
In-Reply-To: <200407132134.58687.matthias.grimm@htp-tel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407162056.10506.matthias.grimm@htp-tel.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
The function usleep() is ok in 2.6.7. I didn't saw that my process had been
stopped and therefore didn't react anymore. After some time of searching I
found the process that stopped my process and why. After that it wasn't
difficult to find the bug in my program.

 Thanks for assistance
    Matthias

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
