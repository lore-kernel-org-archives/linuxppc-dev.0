Date: Tue, 26 Oct 1999 14:44:16 +0200
To: Michael Schmitz <schmitz@amber.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: IR on lombard?
Message-Id: <19991026144416.027540@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 26, 1999, Michael Schmitz
<schmitz@amber.biophys.uni-duesseldorf.de> wrote:


>ttyS1 isn't recognized as IR port on my lombard. How do I dump the device
>tree? 

Get lsprop from ftp://devel.linuxppc.org/users/paulus/misc


and use it from /proc/device-tree


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
