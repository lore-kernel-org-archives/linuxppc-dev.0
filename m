Date: Sun, 11 Nov 2001 13:11:10 -0500
From: Joseph Manojlovich <manojlov@cse.psu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Gxt2000p Patch
Message-ID: <20011111131110.L28196@cardassian.cse.psu.edu>
References: <20011110185747.D28196@cardassian.cse.psu.edu> <Pine.GSO.4.21.0111111102290.10838-100000@mullein.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0111111102290.10838-100000@mullein.sonytel.be>; from geert@linux-m68k.org on Sun, Nov 11, 2001 at 11:03:41AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Nov 11, 2001 at 11:03:41AM +0100, Geert Uytterhoeven wrote:
> What are the values res_start and res_size for which request_mem_region()
> fails? What does /proc/iomem says?
>
> This can only be a workaround for the problem, not a fix. The real fix is
> probably a fix for the global bus resources.

Yes. I guess I left out "quick and dirty" from the title (other emails
I sent had it). I hope the next patch info I sent resolves the issue
more completely. I sent the original hack patch out before my
realization that all of my issues were related to broken PCI resource
allocation, instead of just for the graphics card (thanks Olaf!).

--
Joe Manojlovich
manojlov@cse.psu.edu
"And a thermostat on a home furnace... is that supposed to go to
 5000 degrees, do you think?"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
