Date: Mon, 17 Jan 2000 14:02:19 -0800 (PST)
From: Sean Chitwood <darkmane@w-link.net>
Reply-To: darkmane@w-link.net
To: Kevin Buettner <kev@primenet.com>
cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Help w/ gdb
In-Reply-To: <1000116164658.ZM13760@saguaro.lan>
Message-ID: <Pine.LNX.4.10.10001171358500.1248-100000@darkmane.w-link.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 16 Jan 2000, Kevin Buettner wrote:

> #define SOFUN_ADDRESS_MAYBE_MISSING
> 
> Is it there?  (I'm guessing not.) Try adding the above line to
> tm-linux.h and then rebuild gdb.
> 

	It was not there, but that did not fix my problem. I guess this might be the problem w/ optimization. 

	Damn.....

	Sean aka Darkmane
+------------------------------
+ On October 16, 1999 A.D.
+ Sean Chitwood proudly proclaimed
+ his love for Melissa Webb
+ and made her his lifemate
+------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
