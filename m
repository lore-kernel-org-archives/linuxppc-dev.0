Date: Sat, 21 Apr 2001 20:03:00 -0700
From: Anton Blanchard <anton@samba.org>
To: Peter Bergner <bergner@borg.umn.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-commit@fsmlabs.com, linuxppc-dev@lists.linuxppc.org,
	Cort Dougan <cort@fsmlabs.com>
Subject: Re: CPU features again
Message-ID: <20010421200300.A6234@va.samba.org>
References: <Pine.LNX.4.05.10104181835150.5185-100000@callisto.of.borg> <20010418164753.23516@mailhost.mipsys.com> <20010419132446.A11105@brule.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010419132446.A11105@brule.borg>; from bergner@borg.umn.edu on Thu, Apr 19, 2001 at 01:24:46PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> On a related subject, we're still trying to figure out what to do
> with the "uname -m" thing (ie, ppc vs ppc64) and its use in configure
> scripts, rpm,...

$ uname -m
sparc64

$ ./sparc32 uname -m
sparc

$ cat sparc32.c
int main(int argc, char **argv)
{
        personality(PER_LINUX32);
        execvp(argv[1], &argv[1]);
}

You then build things with sparc32 ./configure etc.

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
