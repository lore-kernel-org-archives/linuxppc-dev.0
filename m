In-Reply-To: <l03130301b50506e36e6d@[7.7.7.7]>
Date: Mon, 27 Mar 2000 16:10:38 +0200
To: Jørgen Tietze <qrulf@e-hund.dk>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Ibook and soundcard
Message-Id: <20000327161038.003716@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Mar 27, 2000, Jørgen Tietze <qrulf@e-hund.dk> wrote:

>Hi I wondered if/when the Ibook's soundcard will be supported, is anyone
>working on it?

Currently, no. However, Apple just posted the source to their new kernel
which, among other things, contain a driver for this chip. So that means
that it is no-longer undocumented and that someone can write a driver for
Linux quite easily. The basic DBDMA stuff should be similar to the
current AWACS driver, but the chip configuration (source selection,
volume, etc...) has to go thru the new KeyLargo I2C bus instead of the
old davbus.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
