Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <40B362BA.3080908@xiphos.ca>
Date: Tue, 25 May 2004 11:14:02 -0400
From: Joshua Lamorie <jpl@xiphos.ca>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Serial-to-socket conversion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gidday there,

I want to remotely access a serial port, but I can't just open a shell
on the remote computer.  What I would like to do is open minicom (or
kermit or pppd) point it to some device local to my computer which then
bridges through a socket to my funky remote serial port.  I can't find
any references to similar code other than perhaps pty-redir.  Sorry for
polluting this mailing list, but if you can point me towards something
more appropriate, I would appreciate it.

Thanks

Joshua

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
