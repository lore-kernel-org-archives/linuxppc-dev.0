Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/3] powerpc: Make rtas console _much_ faster
Date: Sat, 29 Apr 2006 10:00:52 +0200
References: <20060429004019.126937000@localhost.localdomain>
	<200604290245.57507.arnd@arndb.de>
	<1146275817.14733.2.camel@localhost.localdomain>
In-Reply-To: <1146275817.14733.2.camel@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <200604291000.52541.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 29 April 2006 03:56, Michael Ellerman wrote:
> I'll clean this one up a little before merging it as per Ryan's email of
> a week or two ago. New patch today or tomorrow.

Ok, I misremembered the discussion on that patch and it didn't occur
to me that a one-line patch needs cleanup ;-)

Thanks!

> Even though this is 1/3 the rest of the series should be fine to merge,
> right Arnd?

Yes.

	Arnd <><
