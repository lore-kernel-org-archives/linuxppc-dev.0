Return-Path: <michael@ellerman.id.au>
Date: Wed, 22 May 2013 13:37:42 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Dennis Schridde <devurandom@gmx.net>
Subject: Re: PROBLEM: Only 2 of 4 cores used on IBM Cell blades and no
 threads shown in spufs
Message-ID: <20130522033742.GA18345@concordia>
References: <1470334.YUWOQ37ijW@ernie> <20130423091246.GA18195@concordia>
 <1401780.1HKOhdHcrh@ernie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401780.1HKOhdHcrh@ernie>
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 17, 2013 at 05:46:52PM +0200, Dennis Schridde wrote:
> Hello!
> 
> Am Dienstag, 23. April 2013, 19:12:47 schrieb Michael Ellerman:
> > For me it is fixed by applying the following patch, it should be in v3.10:
> > 
> >   http://patchwork.ozlabs.org/patch/230103/
> 
> Can you please also backport this to 3.8? It is still missing in 3.8.12.

It's in 3.8.13.

cheers
