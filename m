Message-ID: <38351400.3032B6FB@arcormail.de>
Date: Fri, 19 Nov 1999 10:10:29 +0100
From: Michael Fenske <michael.fenske@arcormail.de>
Reply-To: michael.fenske@arcormail.de
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel debugging??
References: <19991118193016.014231@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> I had the same problem today. Just remove the "z" option, it will eat
> more bandidth but it works. I beleive it's time to update my rsync or zlib...

Thanks, rsync works without the "z" option. And FYI, I updated rsync to
version 2.3.2 (from linuxcare.com.au) after the first time the problem
occurs, but that doesn't help. Maybe an update of zlib could help ?!

Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
