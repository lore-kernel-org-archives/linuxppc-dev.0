Message-ID: <38133E10.BEDBA1CF@netx4.com>
Date: Sun, 24 Oct 1999 13:12:48 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
CC: Claude Robitaille <crobitaille@videotron.ca>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS Root - I am further ahead
References: <Pine.LNX.4.10.9910241018120.5580-100000@localhost.localdomain> <kfy66zwstjl.fsf@kieraypc01.p.y.ki.era.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:


> Sounds like you haven't made the highly needed MPC8xx modifications
> to glibc. See the archive of this list.

Those are not needed at this point unless you are running with
copyback data cache enabled.  I don't think the kernel normally
sets this mode (in head.S) because you can run with the standard
distribution files and libraries.

Normally, at this point I find the console device isn't working
correctly.  That is, the NFS server isn't properly handling things
in /dev, the symbolic link of /dev/console is wrong, or the
/dev/console node itself isn't correct.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
