Date: Mon, 06 Dec 1999 10:56:02 -0700
From: "Joseph N. Hall" <joseph@5sigma.com>
Reply-To: " <joseph> "@5sigma.com
Subject: pcmcia enet on pb2400 (more info)
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <MailDrop1.2d7j-PPC.991206105602@perlfaq.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The attempt to boot is dying during the pcmcia memory probe.  I
am using the following in config.opts:

>   include port 0x0-0xfff
>   include memory 0x90000000-0x90ffffff

Both slots are filled.  I get a single high beep and then a crash.
The above configuration is reported to work with pcmcia-cs-3.0.8
LinuxPPC R4 + 2.2.1 kernel on a pb2400 (confirmed with a Japanese 
user).  It appears that I am using 2.2.6-15a from the 1999 Q3 RPM.
Is this broken?  If so, what should I try next?

RSVP to the address below or joseph@5sigma.com for more info.
Thanks,

  -joseph

--
Joseph N. Hall, 5 Sigma Productions        mailto:" <joseph> "@5sigma.com
Author, Effective Perl Programming . . . . . http://www.effectiveperl.com
Perl Training  . . . . . . . . . . . . . . .  http://www.perltraining.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
