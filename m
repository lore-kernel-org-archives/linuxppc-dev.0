Date: Tue, 23 Nov 1999 10:45:33 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>,
        Christian Zankel <chris@mvista.com>, linuxppc-dev@lists.linuxppc.org,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
Message-ID: <19991123104533.C16540@hq.fsmlabs.com>
References: <kfypux15ewm.fsf@kieraypc07.p.y.ki.era.ericsson.se> <Pine.HPX.4.10.9911231758050.5120-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.10.9911231758050.5120-100000@gra-ux1.iram.es>; from Gabriel Paubert on Tue, Nov 23, 1999 at 06:01:57PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


That's more of a task for the end users, not the kernel.  Configuring the
system and building a ramdisk isn't really part of the build I don't think.

} Yes, but often they have at least 8Mb of RAM (which was the minimal spec
} for PreP). In this case a few more kB in the bootloader to make it more
} generic do not hurt as long as you can make the run time kernel as small
} as possible. Why not dynamically link the kernel to remove useless code,
} for example have a kernel plus modules and link them selectively at boot
} time depending on the network or SCSI chip, we are a far way from this
} but it should be possible.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
