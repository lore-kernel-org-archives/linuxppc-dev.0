Date: Wed, 7 Apr 2004 09:15:19 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI Memory mapping
Message-ID: <20040407071519.GE2426@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I now realise I sent to the wrong mailing list :-/
(thread was on linuxppc-dev instead of linuxppc-embedded).

Hi,

I know I've been flooding the mailing list with this particular little
topic and thanks to some valuable comments [1], we were able to
pinpoint our problem fairly quickly.

Partly based on a number of related known silicon bugs, I have drafted
the following description (and work-around) that explains our data
corruption.

http://scorpius.homelinux.org/~marc/masterwrite/

[1] There is still one comment which is in the queue to be investigated.

 marc.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
