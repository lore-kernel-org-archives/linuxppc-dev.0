In-Reply-To: <38C580BE.26157A00@claudio.ch>
Date: Wed, 8 Mar 2000 10:56:51 +0100
To: Claudio Nieder <private@claudio.ch>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: 2.2.15pre11 on PB Lombard
Message-Id: <20000308105651.015313@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 7, 2000, Claudio Nieder <private@claudio.ch> wrote:

>hda: Enabling MultiWord DMA 2
>hdc: Enabling MultiWord DMA 2
>ide1: unexpected interrupt, status=0x00, count=1

Hum... I should make sure not to enable interrupts when setting the disk
features... I'll fix that asap.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
