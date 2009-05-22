Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <9e4733910905211152x6ded5c9tadc085bc4bc800e3@mail.gmail.com>
References: <9e4733910905211152x6ded5c9tadc085bc4bc800e3@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 21 May 2009 22:33:40 -0600
Message-ID: <fa686aa40905212133o472a15c1tbc25c793557e2e73@mail.gmail.com>
Subject: Re: Audio and mpc5200 bestcomm tasks
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 21, 2009 at 12:52 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> ALSA really wants to dynamically know the address of the current DMA
> location while transfers are active. This is an important piece of
> implementing pause/resume. Pause doesn't work too well if there is 2s
> of music already queued. The work around is to know the sample rate
> and use the jiffy count to estimate how far into the buffer DMA has
> progressed. But that's not as accurate as just asking the DMA
> hardware.
>
> I poked around in the SRAM data and couldn't find the address. Is it
> there or can the Bestcomm tasks be modified to leave it somewhere
> visible?

It may be possible, but I haven't made any attempts at writing
bestcomm task code.  I've got no idea how difficult it would be.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
