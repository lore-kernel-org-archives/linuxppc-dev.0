Subject: Re: 2.6.0-ben3: Badness in redraw_screen
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Andreas Schwab <schwab@suse.de>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <m3wu8dp6bk.fsf@whitebox.m5r.de>
References: <m3wu8dp6bk.fsf@whitebox.m5r.de>
Content-Type: text/plain
Message-Id: <1072932212.768.27.camel@gaston>
Mime-Version: 1.0
Date: Thu, 01 Jan 2004 15:43:32 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-12-31 at 22:36, Andreas Schwab wrote:
> I'm getting this badness in redraw_screen when my iBook wakes up with
> 2.6.0-ben3:

Just a warning that I added to a bunch of VT functions to spot various
races in the VT code. I've started adding more grabs of the console
semaphore here or there though I 'forgot' some way the sleep code
before pushing 2.6.0-ben3. There's a 2.6.1-rc1-ben1 now online with
that problem gone

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
