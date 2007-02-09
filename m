Return-Path: <mgreer@mvista.com>
Date: Fri, 9 Feb 2007 16:25:33 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: Okay to change default zImage link/load address?
Message-ID: <20070209232533.GE12035@mag.az.mvista.com>
References: <20070209184345.GA28127@mag.az.mvista.com>
	<20070209185107.GA12703@aepfle.de>
	<20070209185528.GB28127@mag.az.mvista.com>
	<45CCCCAD.2040507@am.sony.com>
	<20070209224010.GB7339@localhost.localdomain>
	<20070209232100.GD12035@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070209232100.GD12035@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Olaf Hering <olaf@aepfle.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 09, 2007 at 04:21:00PM -0700, Mark A. Greer wrote:
> On Sat, Feb 10, 2007 at 09:40:10AM +1100, David Gibson wrote:
> 
> > Note that the zImage is already build -fPIC and capable of relocating
> > itself if loaded at an address other than 4MB...
> 
> That doesn't address the issue.
> 
> Many firmwares look at the address in the ELF header and that's where
> they download it, period.  Right now, that address is 4MB, period.
> 4MB doesn't work on some platforms so I'm looking for an acceptable
> alternative.

David, if I sounded rude, I didn't mean to.

It may sound better if you do this:  :)

s/, period/(can't be overridden)/

Mark
