Message-ID: <38133E99.6D04079A@netx4.com>
Date: Sun, 24 Oct 1999 13:15:05 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Claude Robitaille <crobitaille@videotron.ca>
CC: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS Root - I am further ahead
References: <Pine.LNX.4.10.9910241136290.5684-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Claude Robitaille wrote:
> 
> hi Marcus,
> 
> I've just downloaded libc-1.99-8xx from linuxppc.cs.nmt.edu
> and tried it but without success. Is that library known to work?

Yep, I use it all of the time.  It was compiled from the "-o"
version of the source RPM (I don't remember the entire version
string), with the -mcpu=860 flag and with the cache line size
patched to match the 8xx.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
