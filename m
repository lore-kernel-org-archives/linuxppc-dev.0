Date: Tue, 23 Apr 2002 16:05:48 -0700
From: Matt Porter <mporter@mvista.com>
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Status on 405GP i2c driver
Message-ID: <20020423160548.A5009@home.com>
References: <20020422141601.B16319@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020422141601.B16319@ecam.san.rr.com>; from acmay@acmay.homeip.net on Mon, Apr 22, 2002 at 02:16:01PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Apr 22, 2002 at 02:16:01PM -0700, andrew may wrote:
>
> It looks like this question was lasted asked around Jan/Feb, but
> I have not seen an update on the status recently.
>
> I have looked at the i2c-2.6.3 and I am reluctant to spend any
> time working on it since it needs to go through some formating
> changes to get rid of the C++ style comments. I don't want to
> deal with a merge issues of doing a style change unless I know
> it will go in.

I pushed a modified version of Armin's latest updated patch in.
I'd love to see the C-- comments go away but I'm too lazy to play
with it beyond testing it on my platform.  If anybody sends patches
that clean up some more of the ugliness then I'll push them in.

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
