Message-ID: <4106DF1C.8080502@mvista.com>
Date: Tue, 27 Jul 2004 16:02:52 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: jdomogala@acmepacket.com
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Looking for GT64260 MPSC serial console driver
References: <NFBBJCNFKLFMBACPKDKCOEMDEDAA.jdomogala@acmepacket.com> <4106DC44.5060701@mvista.com>
In-Reply-To: <4106DC44.5060701@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark A. Greer wrote:

> I should add that I am currently having problems with that driver on a
> 64360 base board.  I hope to have it working "soon".


Scratch that.  I had a bug in my platform code.  The mpsc *port 0* seems
to work fine on the 64360.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
