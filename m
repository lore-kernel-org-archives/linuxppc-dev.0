Message-ID: <20040630185253.66105.qmail@web52609.mail.yahoo.com>
Date: Wed, 30 Jun 2004 11:52:53 -0700 (PDT)
From: Shamile Khan <shamile@yahoo.com>
Subject: telnet problems - characters not being sent properly
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have an ethernet connection between host and target for
Timesys Linux for AMIRIX AP1 BSP (PPC405 on Virtex II Pro
platform). I can telnet to target and login, but I am
having issues with some chacters not being sent properly to
the target. Specifically, when I type a command, no matter
what I type, I see ((( characters on the screen. Then after
typing some more characters, I am able to send characters
properly. After typing 1 or 2 commands correctly, the
problem repeats itself which is really making telnet hard
to work with. I was wondering if someone has come across
this issue. Please note that NFS mount through ethernet is
working fine. So is tftp.

Shamile


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
