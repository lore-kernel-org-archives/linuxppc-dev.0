Return-Path: <wmb@firmworks.com>
Message-ID: <49014C69.8020408@firmworks.com>
Date: Thu, 23 Oct 2008 18:17:45 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Mitch Bradley <wmb@firmworks.com>, Matt Sealey <matt@genesi-usa.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <4900ED81.3040202@genesi-usa.com> <4900F90B.80703@firmworks.com>
	<4901032F.3090805@genesi-usa.com> <49011C42.2020101@firmworks.com>
	<20081024032944.GE4267@yookeroo.seuss>
In-Reply-To: <20081024032944.GE4267@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> No, no, no, no, no.  Making complex multi-level representations of
> nested things for gpios is just insanity. 


You know, I don't find this "argument" particularly compelling.  But it 
certainly is strongly worded.

>  Just use the same encoded
> format as we already use for gpio descriptors in 'gpios' properties
> (which is gpio controller specific, with length defined by
> #gpio-cells).

http://en.wikipedia.org/wiki/Proof_by_assertion
