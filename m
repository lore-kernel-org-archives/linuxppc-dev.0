Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <200904071854.16818.sr@denx.de>
References: <1239093575-12147-1-git-send-email-sr@denx.de>
	<49DB8271.8050501@freescale.com> <200904071854.16818.sr@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 12 Apr 2009 00:01:12 -0600
Message-ID: <fa686aa40904112301q6bcdd23enc23c745b6198a447@mail.gmail.com>
Subject: Re: [PATCH 3/4 v2] mtd/powerpc: Remove unused "device-width" property
To: Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 7, 2009 at 10:54 AM, Stefan Roese <sr@denx.de> wrote:
> On Tuesday 07 April 2009, Scott Wood wrote:
>> Stefan Roese wrote:
>> > This property is unused. It's not handled as all by the physmap_of
>> > driver. So let's remove it from the documentation.
>> >
>> > Signed-off-by: Stefan Roese <sr@denx.de>
>> > CC: Grant Likely <grant.likely@secretlab.ca>
>>
>> The device tree describes the hardware, not what Linux happens to do
>> with it at the moment.
>>
>> I'd rather keep it.
>
> I find it rather confusing to "see" such bindings that are not supported. One
> could expect something to happen/change after defining this property. So in
> general I think adding unsupported properties to the Documentation is a bad
> idea. But that's just my 2 cents. If the general opinion is to keep this
> property, I'll keep it in of course.

I say keep it.  It is a valid way to describe the hardware regardless
of whether or not the driver supports it yet.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
