Date: Wed, 21 Nov 2001 04:29:04 -0700
From: Matt Porter <mporter@mvista.com>
To: Sarnath Kannan <sparc64@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: VT on SandPoint
Message-ID: <20011121042903.A4106@cx258813-a.chnd1.az.home.com>
References: <20011121123234.12725.qmail@mailweb11.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011121123234.12725.qmail@mailweb11.rediffmail.com>; from sparc64@rediffmail.com on Wed, Nov 21, 2001 at 12:32:34PM -0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Nov 21, 2001 at 12:32:34PM -0000, Sarnath  Kannan wrote:
>
> Hi All,
>  If any1 could tell me sthg on
> how to enable VT on sandpoint, it would
> be of great use.
>  Currently My Console is on a serial line.
> I have a video ( PCI) card, which linux
> identifies but i m not  able to get my console
> on it..
>  I have added "conswitchp = &dummy_console" during
> the initn time.
>   The kernel doesnt even recognize /dev/tty0
> as a valid device.

Works here, Sandpoint X3B w/ 7410 or 8240 and Matrox Millenium I Rev. B.
Enable VT support, console on VT, conswitchp is set properly in
linuxppc_2_4_devel.

Perhaps you aren't using a video driver capable of doing full
initialization?  Most PeeCee card drivers don't.  Does it say
that it is switching console during boot?

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
