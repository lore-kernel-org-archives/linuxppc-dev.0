Date: Thu, 19 Oct 2000 09:22:11 +0200 (CEST)
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: initial console
In-Reply-To: <Pine.LNX.4.10.10010181319270.841-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.21.0010190919000.8107-100000@ipnpcu5>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


First of all : thanks.
On Wed, 18 Oct 2000, Geert Uytterhoeven wrote:
> What does /dev/console look like?
Under 2.2.17 kernel (which boot...)
[root@ipnpwpc3 /dev]>ls -la /dev/console
crw-r--r--    1 root     root       5,   1 oct 19 08:24 /dev/console
is this good or not ? Do you need more information ?
If so how can I get it ?
> Did you enable any device that can provide a console functionality, like e.g.
> CONFIG_VT, CONFIG_SERIAL_CONSOLE?
[xavier@ipnpcu5 linuxppc_2_5]>grep VT .config
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
[xavier@ipnpcu5 linuxppc_2_5]>grep CONFIG_SERIAL_CONSOLE .config
CONFIG_SERIAL_CONSOLE=y

33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
