Message-ID: <009801c02392$d9011ca0$22227c92@intranet.gr>
From: "Yannis Plevrakis" <iple@intracom.gr>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>,
        "Paolo Scaffardi" <arsenio@tin.it>
References: <001701c01e61$958ed240$0a00010a@paoloweb>
Subject: Re: rebooting with the FADS
Date: Thu, 21 Sep 2000 09:11:57 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> on my FADS, i see that it is not possible to reboot from software: you
must
> press the reset buttons to do this.
>

Just a "brute force" alternative:
In case you don't mind having a latency of tens/hundrends of miliseconds
before rebooting
and you want a soft reboot very similar to a hardware one, generating a
HRESET signal,
a very simple approach could be to use the software watchdog timer.

Yannis.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
