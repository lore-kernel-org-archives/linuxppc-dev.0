Message-ID: <F14441D40E5AD3118886005004607AD10BDDDD@MAIL1>
From: "Halfmann, Klaus" <khalfmann@libra.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ibook ttyS0 (modem), and pppd problem, linux-2.2.17pre20ben2
Date: Mon, 9 Oct 2000 12:45:26 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1252"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Conrad H Ziesler [mailto:cziesler@umich.edu] wrote:

> The first time i run pppd after reboot, everything works great.
>
> however, if the remote host abruptly hangs up, then all future pppd
> instances yield the following trace in syslog:
>
> Oct  7 18:35:15 mwatt pppd[7318]: pppd 2.3.11 started by root, uid 0
> Oct  7 18:35:19 mwatt pppd[7318]: Hangup (SIGHUP)
> Oct  7 18:35:19 mwatt pppd[7318]: Connect script failed
>
> that is, pppd aborts without ever running chat.
> nothing i seem to do fixes this except reboot.

I have just the same problem and help myself as follows:
I compiled macserial as a module. So when this problem
hits me I do a rmmod/insmod on macserial and everything
is fine again.

This problem appeard in all 2.2 kernels I had until now.
Of course this is a bug in the macserial driver
(and it may already be known) ...

|       |                  Klaus Halfmann       khalfmann@libra.de
|       |
|    i  | --.  r---  -- |  Libra Software GmbH  Tel +49 (0)621 41997-15
|    |  b-- |  |    a-- |  Erzbergerstr. 17     Fax +49 (0)621 41997-30
L--- |  --- |  |    .---.  68165 Mannheim

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
