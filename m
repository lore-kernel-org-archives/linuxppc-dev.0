Message-Id: <200006122355.TAA07284@nerd-xing.mit.edu>
To: guillaume.laures@noos.fr
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SMP 
In-Reply-To: Your message of "Mon, 12 Jun 2000 23:09:35 +0200."
             <3945518F.B3185904@noos.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Jun 2000 19:55:17 -0400
From: Charles E Leiserson Jr <locutus@MIT.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Unfortunately, it doesn't work. BootX 1.2.2 shows up only one penguin, and I get
> the same /proc/cpuinfo.
> I realized that I have this oddity in dmesg :
>
> Entering SMP Mode...
> Processor 1 is stuck.

Ah, this problem.  I had it too with my nPower400.  I got rid of it by shutting down completely, and starting up again (into Linux).  I haven't had that problem since, at least with my kernel...


					- Ricky


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
