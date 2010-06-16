Return-Path: <richardcochran@gmail.com>
Date: Wed, 16 Jun 2010 08:54:35 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 11/12] ptp: Added a clock driver for the IXP46x.
Message-ID: <20100616065435.GE2887@riccoc20.at.omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
	<0c03ef3e283c6b3ef58feaf1f77ccb0fd605010b.1276615626.git.richard.cochran@omicron.at>
	<AANLkTinPDaWNvUG8q8RdvRUga-qrPlSV2H5TkzVVMaFn@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinPDaWNvUG8q8RdvRUga-qrPlSV2H5TkzVVMaFn@mail.gmail.com>
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 15, 2010 at 12:41:56PM -0600, Grant Likely wrote:
> Nitpick.  We use all lower case names for structures in Linux.

Yes, I know, but in this case an exception makes sense.

I prefer to use the exact same register mnemonics as in the hardware
documentation, whenever possible. That way, anyone later working on
the driver with hardware manual in hand (and they should be doing that
way) will immediately see the connection.

> You want to get stuff as fast as possible, but there is a udelay()
> that just chews up CPU time.  Would cpu_relax() be sufficient with a
> time-based exit condition in the loop?

I am not sure. What does cpu_relax() do exactly, and when is it safe
to call?

Thanks,
Richard
