Cc: linuxppc-embedded@lists.linuxppc.org, distribution@linux01.hasler.ascom.ch
Message-ID: <39649719.6A828478@lucent.com>
Date: Thu, 06 Jul 2000 09:26:33 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: Ruedi.Hofer@ascom.ch
Subject: Re: newlib, uclib
References: <0FXA0055X023NC@pmdf-it.hasler.ascom.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ruedi.Hofer@ascom.ch wrote:
> In order to build a commercially successful product I have to reduce the footprint of the system.
> Having a quick look at the files showed me, that the largest files are the libs (libc.so.6 = 4M) ... as u all know.

Initially I also thought I would have to strip down the libraries
to reduce their footprint. But then I realized that Linux is a demand-
paged system, and only the pages which actually get used will be
loaded into memory. In our case only memory is an issue, the disk
space required is not important. So making libc include _everything_
is actually a good design decision, IMHO, because it avoids users
having to configure it, picking and choosing among thousands of
library functions.


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
