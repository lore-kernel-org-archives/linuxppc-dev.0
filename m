From: Tibor Pausz <pausz@stud.uni-frankfurt.de>
To: Chas Williams <chas@cmf.nrl.navy.mil>
Cc: jingai <jingai@floatingpenguins.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Status of PCI-PCI bridge on UMAX S900
Date: Fri, 5 Jan 2001 20:51:03 +0100
Message-Id: <19341130132247.266@mail.server.uni-frankfurt.de>
In-Reply-To: <200101042226.f04MQ6Z20543@ginger.cmf.nrl.navy.mil>
References: <200101042226.f04MQ6Z20543@ginger.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Don, 4. Jan 2001, Chas Williams <chas@cmf.nrl.navy.mil> wrote:

>i was wrong about the checking for the interrupts property before
>allocating an interrupt. the correct patch follows:

It doesn't no longer crash the machine, but my ISDN card doesn't
get a correct interrupt. Excatly the some stuff w/o the patch.

Well, I didn't know if the ISDN card works at all. So I swapped
the SCSI card and the ISDN card. The ISDN card crashes now the machine,
but without the ISDN card the SCSI cards fine behind the PCI bridge :-)

I don't have any problem (yet), hdparm cache trough put around 30MB/s.

(it's a SYM 53c875 card)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
