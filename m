Return-Path: <michael@ellerman.id.au>
Date: Tue, 23 Apr 2013 23:19:11 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Dennis Schridde <devurandom@gmx.net>
Subject: Re: PROBLEM: Only 2 of 4 cores used on IBM Cell blades and no
 threads shown in spufs
Message-ID: <20130423131911.GA1078@concordia>
References: <1470334.YUWOQ37ijW@ernie> <20130423091246.GA18195@concordia>
 <20130423135155.7b307094@samson> <3242341.cjDFP0lvB2@ernie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3242341.cjDFP0lvB2@ernie>
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 23, 2013 at 03:16:53PM +0200, Dennis Schridde wrote:
> Hello!
> 
> Am Dienstag, 23. April 2013, 13:51:55 schrieb Dennis Schridde:
> > Am Tue, 23 Apr 2013 19:12:47 +1000
> > schrieb Michael Ellerman <michael@ellerman.id.au>:
> > > On Mon, Apr 22, 2013 at 06:44:13PM +0200, Dennis Schridde wrote:
> > > For me it is fixed by applying the following patch, it should be in
> > > v3.10:
> > I am currently compiling the patched kernel. Will report back with the
> > results later.
> 
> Thanks! The patch has the intended result on my Linux 3.8.8 kernel. All 4 CPU 
> cores are now being used and the cellminer hashrate went up from 42Mh/s to 
> 62Mh/s (with 2 PPE and 16 SPE threads, just as before).

Excellent.

> Could it be backported, especially to 3.8?

Yes we'll send it to stable.

cheers
