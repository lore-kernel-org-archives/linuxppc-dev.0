Date: Mon, 20 Mar 2000 21:50:33 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Florian Lohoff <flo@rfc822.org>
cc: David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC/MCA RS/6000 port ?
In-Reply-To: <20000320205346.F1363@paradigm.rfc822.org>
Message-ID: <Pine.HPX.4.10.10003202146440.28648-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 20 Mar 2000, Florian Lohoff wrote:

> What does this mean in concern to the existing PPC port ? As i understand
> the linuxppc port does already run on 601 - So the CPU is already
> supported - Leaves us with bootstrap/bootprom and special architecture
> (interrupts, scsi controller, serial ports etc)

Mostly, does your firmware provide residual data to the loaded program
and do you know at which physical address you can access serial ports for
example ?

I have code to dump residual data if you can upload it to some other
machine. This code could also probably be run standalone to dump on serial
port and capture on another machine.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
