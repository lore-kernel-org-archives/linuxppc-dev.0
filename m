Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Date: Fri, 9 Sep 2005 00:36:39 +0200
References: <f2ea45e1b2a9689c450811a61ed46183@embeddededge.com>
	<39A39EEE-E3B1-4D34-BC6E-854C3EF56C7D@freescale.com>
In-Reply-To: <39A39EEE-E3B1-4D34-BC6E-854C3EF56C7D@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509090036.39992.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org,
	pantelis.antoniou@gmail.com
Subject: Re: cpu features testing 32 vs 64 bit
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Freedag 09 September 2005 00:02, Kumar Gala wrote:
> 
> On Sep 8, 2005, at 4:48 PM, Dan Malek wrote:
> >
> > If we #define CPU_FTR_xxx as a 0 or all 1's for processors that have
> > or don't have these features, will the compiler be smart enough to
> > recognize an always true or false condition and remove the
> > test (or code as appropriate)?
> 
> The compiler is smart enough in this case since cpu_has_feature() is  
> an inline function.

I actually wrote a patch that solves the problem in a very generic way,
see http://patchwork.ozlabs.org/linuxppc/patch?id=1048 .
I don't remember exactly if there were serious objections against
the patch at that time, but it looks like a much cleaner solution to me
than defining CPU_FTR_xxx to different values depending on the
configuration.

	Arnd <><
