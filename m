In-Reply-To: <20040619141602.GD18025@pegasos>
References: <1087595028.2061.295.camel@gaston> <Pine.LNX.4.44L0.0406190953120.19842-100000@netrider.rowland.org> <20040619141602.GD18025@pegasos>
Mime-Version: 1.0 (Apple Message framework v618)
Message-Id: <9A441082-C35B-11D8-B9CB-000A95A4DC02@kernel.crashing.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Alan Cox <alan@www.pagan.org.uk>, Nicolas DET <nd@bplan-gmbh.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux-USB <linux-usb-devel@lists.sourceforge.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [linux-usb-devel] [Patch] for UHCI driver (from kernel 2.6.6).
Date: Mon, 21 Jun 2004 10:18:40 +0200
To: Sven Luther <sven.luther@wanadoo.fr>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Enforced In-Order Execution of I/O. Page 8-61 of the Programing
> Environments for 32-Bit Microprocessors, by motorola, well, at least on
> my version.

Don't use that old stuff; use either the new PEM or the Book I/II/III:

PEM (64- and 32-bit) v2.0:
http://www-3.ibm.com/chips/techlib/techlib.nsf/techdocs/
F6153E213FDD912E87256D49006C6541/$file/pem._64bit.d20030611.pdf

PowerPC Book I/II/III v2.01:
www-106.ibm.com/developerworks/eserver/pdfs/archpub1.pdf
www-106.ibm.com/developerworks/eserver/pdfs/archpub2.pdf
www-106.ibm.com/developerworks/eserver/pdfs/archpub3.pdf

Most of the time the Books are better; sometimes the PEM helps
as well.

Have fun,


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
