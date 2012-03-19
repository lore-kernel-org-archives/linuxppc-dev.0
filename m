Return-Path: <B04825@freescale.com>
Message-ID: <4F676D9E.6000609@freescale.com>
Date: Mon, 19 Mar 2012 12:32:14 -0500
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Device Tree Bindings for Freescale TDM controller
References: <1331861451-15427-1-git-send-email-poonam.aggrwal@freescale.com>
 <4F63868D.1030507@freescale.com>
 <ACB6D0C0104CFF42A45A5D82A0DD4F3D09D518@039-SN2MPN1-013.039d.mgd.msft.net>
 <CAOZdJXVU=1bW8_OTMecJHuWaa6_023UnUsfQTX8MGqd3E4SRAg@mail.gmail.com>
 <4F676C9D.2070301@freescale.com>
In-Reply-To: <4F676C9D.2070301@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Singh Sandeep-B37400 <B37400@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
>> > Scott, are you suggesting that Poonam put a non-zero number in the DTS
>> > for clock-frequency?  If so, then I don't think that's a good idea, if
>> > U-Boot will always override it.

> This is a device tree binding document, not U-Boot specific.  It
> describes what Linux (or another OS) can expect to see, not how it gets
> there.

That doesn't really answer my question.  We currently have many properties
that define a clock frequency, and the DTS sets them all to 0, with the
intent of having U-Boot update them.  Now maybe these should all be
deleted, but it seems that setting them to a non-zero value is wrong,
because it might mislead people into thinking that the property is not
updated by U-Boot.  When you see something like this:

	clock-frequency = <0>;

It's pretty obvious that U-boot will fill it in.

-- 
Timur Tabi
Linux kernel developer at Freescale
