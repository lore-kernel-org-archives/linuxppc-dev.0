Date: Fri, 26 Oct 2001 05:06:20 -0700
From: Matt Porter <mmporter@home.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Lots of changes to PReP booting
Message-ID: <20011026050620.A14881@cx258813-a.chnd1.az.home.com>
References: <20011025175915.A6439@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011025175915.A6439@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Thu, Oct 25, 2001 at 05:59:15PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 25, 2001 at 05:59:15PM -0700, Tom Rini wrote:
>
> Hey all.  Can people _please_ go and test this (disk and net if
> possible) and tell me if their machine still works?  The following
> changes have been made:
> 1) On 'znetboot' and 'znetboot.initrd', no longer give mkprep the -pbp
> option.  This allows my PowerStack (PPCBUG) to netboot successfully.
> This _hopefully_ won't break anyone else tho.

Why?  You wanted to netboot from PPCBUG with PReP Network Boot disabled?
My PowerStack's have been booting fine with the -pbp'ed image (one
with the PReP header intact).  We've been doing it this way for years
now.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
