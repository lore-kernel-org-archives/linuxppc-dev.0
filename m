Message-ID: <38A75E46.B89491B8@netx4.com>
Date: Sun, 13 Feb 2000 20:45:42 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: Tobias Otto-Adamczak <Tobias.Otto-Adamczak@e-technik.tu-chemnitz.de>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: On-Chip-Debugging for MPC 860 ?
References: <20000213233353.B879884F0@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> GDB support for PowerPC BDM under Linux isn't yet available.....

The HMI BMDs for 8xx/5xx/4xx series work just fine with GDB on any
host platform.  There are many others supported as well, just
take a look at all of the remote-* devices in the GDB sources.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
