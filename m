Message-ID: <38D8EF56.17970FBC@astro.wisc.edu>
Date: Wed, 22 Mar 2000 10:05:42 -0600
From: Matt Haffner <haffner@astro.wisc.edu>
Reply-To: haffner@astro.wisc.edu
MIME-Version: 1.0
To: DeRobertis <derobert@erols.com>
CC: Linux/PCC Development Mailing List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: stty crtscts < /dev/ttyS1
References: <l03130302b4fd80d3a908@[216.164.130.191]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


DeRobertis wrote:
>
> Hardware flow control is broken. The command in the subject line (stty
> crtscts < /dev/ttyS1) freezes linux 2.2.14. Any idea why?

Try this syntax: "stty -F /dev/ttyS1 crtscts". There's a comment in the
info doc for stty that letting the shell open the device may block in
certain situations.

mh
--
Matt Haffner                      /|------|\    University of Wisconsin
Dept. of Astronomy               /|--------|\            Madison
haffner@astro.wisc.edu          /|----------|\
           WHAM project -- http://www.astro.wisc.edu/wham

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
