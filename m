Message-ID: <40F55AAC.3000405@gcctech.com>
Date: Wed, 14 Jul 2004 12:09:16 -0400
From: "Christopher R. Johnson" <cjohnson@gcctech.com>
Reply-To: cjohnson@gcctech.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: looking for an implementation
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm looking at creating a "server-side" parallel port driver for a
system that wants to look like a parallel port -based printer.  Some
(probably dumb) questions:

1. Should the existing parport arch be the right way to do this?  I
suppose I'll have to write low-level support for the particular
device/chipset, etc.

2. Or perhaps a simpler kernel driver which handles just the minimum
needed to implement the "server"?

3. Does anyone know of any examples of #2?

4. I suppose that (at least on an intel machine) a user-mode program
with ioperms might be able to do this, but I'm on ppc405.  Is this still
a possibility on ppc?

any observations or comments are appreciated


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
