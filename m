Date: Mon, 24 Nov 2003 17:35:20 +0100 (CET)
From: Marius Groeger <mgroeger@sysgo.com>
To: Jaap-Jan Boor <jjboor@aimsys.nl>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Preemptive Kernel and MPC8xx ???
In-Reply-To: <B82FB2A3-1E4E-11D8-A8D4-003065E2BB06@aimsys.nl>
Message-ID: <Pine.LNX.4.56.0311241732200.2581@mag.devdep.sysgo.de>
References: <3FC0A1D3.70706@imc-berlin.de> <B82FB2A3-1E4E-11D8-A8D4-003065E2BB06@aimsys.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 24 Nov 2003, Jaap-Jan Boor wrote:

> Yes I do on 2.4.20 and 2.4.22 from kernel.org. So far all seems
> to work but didn't do any measurements on it.
> (I both use the preempt and low-latency patches)

AFAIK, you can pretty much drop the low-latency patch in favor of
using the lock-breaking patch. It is also available from Robert Love
at the cited home page.

Marius

--
Marius Groeger <mgroeger@sysgo.de>
Project Manager

SYSGO Real-Time Solutions AG | Embedded and Real-Time Software
Am Pfaffenstein 14
55270 Klein-Winternheim, Germany

Voice: +49-6136-9948-0 | FAX: +49-6136-9948-10
www.sysgo.de | www.elinos.com | www.osek.de

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
