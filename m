Return-Path: <wmb@firmworks.com>
Message-ID: <49025DE0.6070403@firmworks.com>
Date: Fri, 24 Oct 2008 13:44:32 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <4900ED81.3040202@genesi-usa.com> <4900F90B.80703@firmworks.com>
	<4901032F.3090805@genesi-usa.com> <49011C42.2020101@firmworks.com>
	<49024646.3050300@genesi-usa.com>
In-Reply-To: <49024646.3050300@genesi-usa.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Right. I had a similar discussion about this the other day with Anton (I
> think he forwarded it here but I wasn't subscribed at that point..). The
> current ideology for device trees is to get rid of device_type for new
> trees that aren't OF-based. I think it's relevant to give nodes fancy
> names (i.e. not "timer" or even "ethernet") since the name property is
> entirely descriptive in nature. I also think it's relevant that 
> device_type
> still exists because since the name is totally irrelevant except from a
> user-friendliness point of view, marking a device as a generic type is
> quite important (device_type = serial, ethernet, rtc, keyboard) where
> compatible properties are usually wildly over-specific.

I don't use device_type much, if at all, anymore.  Generic name + compatible
just works better than device_type + specific name.  When I write code that
has to find a node that is suitable for a given purpose, I look for the 
existence
of suitable methods and perhaps other properties.  I was just too hard to
keep the list of device_type values properly synchronized with all the 
possible
things that you might want to infer from that set of names.

device_type is one of those things that seemed like a good idea at the time,
but didn't work out as well as I had hoped.
