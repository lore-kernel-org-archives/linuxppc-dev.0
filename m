Message-ID: <299848370240D611A24400B0D079FBEB91CFDB@smtcn3>
From: Zhang Qiang MT-CN <Qiang.Zhang@mt.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: smbclient on my MPC823 board
Date: Tue, 10 Jun 2003 17:01:56 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, my friends:
  I'm trying to get Samba-2.2.1a running on my MPC823 board. I've got
everything compiled and loaded into my target board successfully, when I
invoke the following command:" /usr/local/samba/bin/smbclient -L WinHost",
it print "ERROR: Could not determine network interfaces, you must use a
interfaces config line" and exit.  I can't find the way to solve this
problem after some tries, could someone tell me how to overcome it? The
kernel of my target board is 2.4.4. Thanks very much.

Best Regards

Frank Zhang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
