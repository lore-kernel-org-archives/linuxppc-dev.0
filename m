Return-Path: <trini@kernel.crashing.org>
Date: Tue, 26 Oct 2004 07:35:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
Message-ID: <20041026143514.GQ25154@smtp.west.cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DB95@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DB95@ismail.innsys.innovsys.com>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 uart early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 22, 2004 at 05:01:54PM -0500, Rune Torgersen wrote:
> > From: Tom Rini [mailto:trini@kernel.crashing.org] 
> > On Thu, Oct 21, 2004 at 04:57:56PM -0500, Rune Torgersen wrote:
> > > BTW..
> > > What are the device node numbers for ttyCPM[0..5] ?
> > 
> > 204 42...45 (devices.txt in linuxppc-2.5, Pantelis ever 
> > figure out what to do about the device # conflict with the 
> > i.MX driver so we can push that small bit upstream ?)
> 
> Aparently not that simple.... I looked in the source, and it depends if 
> an 8250 stype serial port is defined or not...
> 
> #ifndef CONFIG_SERIAL_8250
> #define SERIAL_CPM_MAJOR	TTY_MAJOR
> #define SERIAL_CPM_MINOR	64
> #else
> #define SERIAL_CPM_MAJOR	204
> #define SERIAL_CPM_MINOR	42
> #endif
> 
> Urgh...

That doesn't make sense.  Pantelis?

-- 
Tom Rini
http://gate.crashing.org/~trini/
