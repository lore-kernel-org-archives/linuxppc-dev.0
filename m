Message-ID: <38A64DF1.FDEF5815@erols.com>
Date: Sun, 13 Feb 2000 01:23:45 -0500
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: ramp@oddjob.uchicago.edu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.43 failed
References: <Pine.LNX.4.10.10002122212490.4975-100000@xpol.uchicago.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


ramp@oddjob.uchicago.edu wrote:

> What should my /etc/sysconfig/keyboard and /etc/sysconfig/mouse be?
> My current files are
> [ramp@localhost ~]$ cat /etc/sysconfig/keyboard
> KEYTABLE=
> KEYBOARDTYPE="usb"
> [ramp@localhost ~]$ cat /etc/sysconfig/mouse
> MOUSETYPE="Busmouse"
> XMOUSETYPE="BusMouse"
> FULLNAME="Universal Serial Bus 3+ Button Mouse (USB)"
> XEMU3=yes

You want to set your mouse type to ps2 (this is well documented in the
install guides...)

HTH
--Nelson Abramson

--
Shouldn't people be arrested and persecuted for engaging in their
constitutional rights?  http://www.opendvd.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
