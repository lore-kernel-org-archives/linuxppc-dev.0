In-Reply-To: <Pine.LNX.3.96.991118010730.21026K-100000@shell>
Date: Thu, 18 Nov 1999 11:08:50 +0100
To: linuxppc-dev@lists.linuxppc.org, yellowdog-devel@lists.yellowdoglinux.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: iMac 350/DV/DV SE Linux HowTo
Message-Id: <19991118110850.015624@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 18, 1999, John Buswell <johnb@one.net> wrote:

>The team at iMac Linux (http://www.imaclinux.net) has managed to get the
>iMac DV to boot linux to a usable point. We have put together a small
>howto on how to achieve this Open Firmware boot and how to kludge a root
>file system onto your iMac.

If this kernel is based on my very latest patches (I uploaded a new
version yesterday, I forgot to mention it, sorry), then it boots the
Sawtooth G4. On this machine, only one USB port works (I'll have to wait
for Paul to get his machine so he can look at what's wrong, It's
difficult to fix this remotely), but the rest of the kernel looks ok.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
