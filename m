Date: 23 Oct 2002 13:47:39 -0000
Message-ID: <20021023134739.6577.qmail@mailweb33.rediffmail.com>
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Illegal instructions in swapper during nfs mount
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have just now enabled the nfs mount of root file system for
linux 2.4.3.
after this when I boot i get so many repeated messages like..

[swapper:1] Illegal instruction xxxxx at xxxxxx

[swapper:1] Illegal instruction yyyyy at yyyyyy at

......
and similar many illegal instructions at different addresses.

in System.map if i watch for these adreses they are mostly from
routines in linux/net/* and linux/net/ipv4/devinet.c.

Can it be a  compiler problem ..?
if it is a nfs related problem do I need to apply any patch..

Best Regards.
Atul



__________________________________________________________


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
