Date: Sun, 2 Feb 2003 16:35:41 -0500
From: Manuj Dhingra <manuj_dhingra@ae.gatech.edu>
To: Owen Stampflee <owen@stampflee.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: VGA out/External Monitor on ibook 2
Message-ID: <20030202213541.GC22344@haar.ae.gatech.edu>
References: <20030120155921.GA22300@haar.ae.gatech.edu> <1043086974.2456.9.camel@tsunami.lan.stampflee.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
In-Reply-To: <1043086974.2456.9.camel@tsunami.lan.stampflee.com>; from owen@stampflee.com on Mon, Jan 20, 2003 at 13:22:54 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Owen,

I sent the dumps (directly to you) is a seperate mail.

When originally searching for a solution, I had found suggestions as to
connecting the VGA out to scope. Recently I did that and found that hsync
and vsync frequencies are as they should be (match with the fbset output).

However, the relative phase seems to be oscillating.

I was also wondering if "mirroring" has worked with the newer ibooks, i.e.
ones with the radeon chip.

Regards,
-manuj

On Jan 20, 2003  13:22 Monday Owen Stampflee wrote:
>
> > case 1: Monitor connected at boot up
> > The external monitor is fine at depth 8, resolution 1024x768-8@60Hz.
> > Changing the depth (text mode) with fbset makes the font look like the
> > wrong depth. It feels like font depth has changed but not the display
> > depth. The internal-LCD display stays just fine.
> Starting X will screw up the secondary display in this scenario too.
>
> > Has this been solved? If not, how can I help?
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
