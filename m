Return-Path: <bwarren@qstreams.com>
Received: from web308.biz.mail.mud.yahoo.com (web308.biz.mail.mud.yahoo.com
	[68.142.199.184]) by ozlabs.org (Postfix) with SMTP id 346B8DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 01:29:22 +1100 (EST)
Date: Wed, 10 Jan 2007 06:22:40 -0800 (PST)
From: Ben Warren <bwarren@qstreams.com>
Subject: Re: Using fixed_phy with gianfar
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20070110161145.3d8b0c77@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <880857.53326.qm@web308.biz.mail.mud.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks Vitaly!

--- Vitaly Bordug <vbordug@ru.mvista.com> wrote:

> No, you do not miss - this is an issue. In fact MDIO
> bus was changed for numeric for gianfar-stuff, and
> has been remaining string for fs_enet. I think it
> makes sense to average this up, and will try to do
> that once will get 8349-mitx which is gianfar+ fixed
> user.
> 
> The point is that fixed should be updated to numeric
> MDIO address encoding. This has to come through
> netdev, so I'll try to get it fixed by the next
> merge window.
> 
> --
> Sincerely, Vitaly
> 

Ideally (for me anyway), we'd be able to pass some
fixed phy information via the device tree, for example
speed and duplexity.  This way a board could, for
example, connect to one switch via RvMII @100FD and
another via GMII @1000FD.  Having parameters as
numeric limits this capability, but presumably a
simple encoding scheme could be make it work.  

I'm sure you've already thought of this, though...

cheers,
Ben
