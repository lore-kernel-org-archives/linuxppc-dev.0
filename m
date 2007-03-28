Return-Path: <mgreer@mvista.com>
Date: Tue, 27 Mar 2007 18:36:18 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Move bootwrapper ELF parsing routines to a file
Message-ID: <20070328013618.GC7097@mag.az.mvista.com>
References: <20070327222950.GB1266@mag.az.mvista.com>
	<20070328012554.GA27401@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070328012554.GA27401@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 28, 2007 at 11:25:54AM +1000, David Gibson wrote:
> On Tue, Mar 27, 2007 at 03:29:50PM -0700, Mark A. Greer wrote:
> > The ELF parsing routines local to arch/powerpc/boot/main.c are useful
> > to other callers therefore move them to their own file.
> 
> Which other callers, out of curiosity?

Its in: http://ozlabs.org/pipermail/linuxppc-dev/2007-March/033672.html

Mark
