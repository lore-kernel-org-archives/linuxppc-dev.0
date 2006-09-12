Return-Path: <olof@lixom.net>
Date: Tue, 12 Sep 2006 16:44:43 -0500
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [PATCH] powerpc: allow PHBs anywhere in the
	device	tree
Message-ID: <20060912164443.231bc01e@localhost.localdomain>
In-Reply-To: <200609122316.21820.arnd@arndb.de>
References: <200609121952.04779.arnd.bergmann@de.ibm.com>
	<20060912145438.30b6bf80@localhost.localdomain>
	<200609122316.21820.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 12 Sep 2006 23:16:21 +0200 Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 12 September 2006 21:54, Olof Johansson wrote:
> > !strcasecmp(...) instead?
> 
> I do that normally for functions that return either a truth value
> or a pointer to an object that may be NULL, whereas strcasecmp
> returns a numerical value that I'm checking for a specific result.
> This is also consistant with how it is used elsewhere in the file.

Ok.

> > Do they ever exist in non-lowercase versions? Old code just did
> > strcmp().
> 
> I took that from device_is_compatible(), which also does
> strncasecmp, so I assumed that was done for a reason.

I think it might be because compatible is by tradition less specific. I
was also mostly looking at the patch, not the rest of the file. Either
is fine with me though, I just wanted to bring it up.



-Olof
