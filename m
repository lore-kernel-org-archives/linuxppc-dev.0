Date: Fri, 2 Apr 1999 13:22:26 +0200 (MET DST)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: Michael Lundkvist <ml@epact.se>
cc: linuxppc-dev@lists.linuxppc.org
Subject: MVME2306 problems dragging on
In-Reply-To: <qp1zigcz4c.fsf@erbium.epact.se>
Message-ID: <Pine.SO4.4.05.9904021252040.23869-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello everyone,

I'm still trying to get our board to run LinuxPPC. So far, I've come to
booting the Linux kernel. This kernel can also mount its NFS fs.

There seems to be a problem with the serial line settings. After the
kernel says : ``Freeing unused memory : [...] open firmware'', the
serial console gets flooded with two kinds of similar messages :

``request_irq(): irq 4 handler c008dae8 name serial dev_id 0000`` and
``request_irq(): irq 4 handler c0000000 name <NULL> dev_id 0000``.

BTW, I'm using a /dev/console with major 5 minor 1. Inbetween those
messages, I see some errors that seem to come from init. I have no update
daemon, and bash cannot be loaded because it cannot find its libtermcap.
When I manually make a link to libtermcap, there are no more errors,
but also no more screen output at all.
  
Does anyone know how to get it correctly running ?

+-----------------------------------------------------------------+
|   David 'Septimus' De Ridder   | "Never underestimate the       |  
|                                |  power of the soul unleashed." |
| <david.de.ridder@bitsmart.com> |   - 'Essence Flare', M:TG      |
+-----------------------------------------------------------------+

--
"I want you to find happiness."
 - Marilyn Monroe in 'Gentlemen prefer Blondes'



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
